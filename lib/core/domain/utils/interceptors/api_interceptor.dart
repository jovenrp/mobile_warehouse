import 'dart:async';
import 'dart:io';

import 'package:appdynamics_mobilesdk/appdynamics_mobilesdk.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/core/data/services/utils/api_error_transformer.dart';
import 'package:mobile_warehouse/core/data/services/utils/rsa_generator.dart';
import 'package:mobile_warehouse/core/data/services/utils/user_agent.dart';
import 'package:mobile_warehouse/core/domain/models/errors/api_error.dart';
import 'package:mobile_warehouse/core/domain/utils/platform/actiontrak_platform.dart';
import 'package:package_info/package_info.dart';
import 'package:pedantic/pedantic.dart';
import 'package:uuid/uuid.dart';

class DioCancellationTokens {
  factory DioCancellationTokens() {
    return _singleton;
  }

  DioCancellationTokens._internal();

  static DioCancellationTokens instance = DioCancellationTokens();

  static final DioCancellationTokens _singleton =
      DioCancellationTokens._internal();

  CancelToken all = CancelToken();

  void renewCancelToken() {
    all = CancelToken();
  }
}

typedef InternetConnectionBlock = Future<dynamic> Function(
    RequestOptions, ErrorInterceptorHandler);

class ApiInterceptor extends Interceptor {
  ApiInterceptor(
    this._persistenceService, {
    required this.userAgent,
    required this.gomoPlatform,
    this.appVersion,
    this.buildNumber,
    required this.onForbiddenException,
    required this.onRequiredUpdateError,
    required this.onServiceUnavailableError,
    required this.onUnauthenticatedError,
    required this.onApiDeprecationError,
    required this.onNoInternetError,
  });

  static const String includeDwnToken = 'include-dwn-token';
  static const String apiDynamicUrl = 'api-dynamic-url';

  final PersistenceService _persistenceService;
  final ValueChanged<ForbiddenException> onForbiddenException;
  final ValueChanged<RequiredUpdateException> onRequiredUpdateError;
  final ValueChanged<ServiceUnavailableException> onServiceUnavailableError;
  final ValueChanged<UnauthorizedException> onUnauthenticatedError;
  final ValueChanged<DeprecationException> onApiDeprecationError;
  final InternetConnectionBlock onNoInternetError;

  final UserAgent userAgent;
  final ActionTRAKPlatform gomoPlatform;

  // Custom app version and build numbers
  final String? appVersion;
  final String? buildNumber;

  final Map<String, AppdynamicsHttpRequestTracker> _trackerMap =
      <String, AppdynamicsHttpRequestTracker>{};

  PackageInfo? _packageInfo;

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    _reportApiPerformance(error.response);

    final ApiServiceException exception = ApiErrorTransformer.transform(error);
    if (_shouldRetry(error)) {
      onNoInternetError(error.requestOptions, handler);
    } else if (exception is ForbiddenException) {
      onForbiddenException(exception);
      super.onError(error, handler);
    } else if (exception is RequiredUpdateException) {
      onRequiredUpdateError(exception);
    } else if (exception is ServiceUnavailableException) {
      onServiceUnavailableError(exception);
    } else if (exception is UnauthorizedException) {
      onUnauthenticatedError(exception);
    } else if (exception is DeprecationException) {
      onApiDeprecationError(exception);
      super.onError(error, handler);
    } else {
      super.onError(error, handler);
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }

  @override
  Future<dynamic> onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    _reportApiPerformance(response);
    return super.onResponse(response, handler);
  }

  void _reportApiPerformance(Response<dynamic>? response) {
    if (response != null) {
      Map<String, String> headers = <String, String>{};
      response.headers.forEach((String name, List<String> values) {
        values.forEach((String element) {
          headers[name] = element;
        });
      });

      String requestUUID =
          response.requestOptions.headers['request_uuid'] ?? '';
      if (requestUUID.isNotEmpty) {
        AppdynamicsHttpRequestTracker? tracker = _trackerMap[requestUUID];
        if (tracker != null) {
          logger.d('[APPDYNAMICS] FINISHING RESPONSE for request '
              '$requestUUID ${response.statusCode}');
          tracker.withResponseCode(response.statusCode ?? -1);
          tracker.withResponseHeaderFields(headers);
          unawaited(tracker.reportDone());
          _trackerMap.remove(requestUUID);
        } else {
          logger.d('[APPDYNAMICS] has not started yet');
        }
      }
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // set cancellation token to all requests
    options.cancelToken = DioCancellationTokens.instance.all;
    _packageInfo ??= await gomoPlatform.getPackageInfo();

    // ! WARNING: We need to know what this key does, changing it to `_packageInfo.version` causes issues
    final String _appVersion = appVersion ?? _packageInfo?.version ?? '';

    final String osName = await gomoPlatform.getOsName();
    final String osVersion = await gomoPlatform.getOsVersion();
    final String deviceModel = await gomoPlatform.getDeviceModel();
    final String manufacturer = await gomoPlatform.getManufacturer();
    final String brand = await gomoPlatform.getBrand();
    final String deviceId = await gomoPlatform.getDeviceId();
    final String requestUUID = const Uuid().v4();

    final bool hasAppDynamicsStarted =
        (await _persistenceService.hasStartedAppDynamics.get()) ?? false;

    if (requestUUID.isNotEmpty && hasAppDynamicsStarted) {
      logger.d('[APPDYNAMICS] has started');
      AppdynamicsHttpRequestTracker tracker =
          AppdynamicsMobilesdk.startRequest(options.uri.toString());
      _trackerMap[requestUUID] = tracker;
    }

    options.headers.addAll(<String, String>{
      'platform': 'APP',
      'request_uuid': requestUUID,
      'channel': _currentPlatform(),
      'osname': osName,
      'osversion': osVersion,
      'devicemodel': deviceModel,
      'manufacturer': manufacturer,
      'brand': brand,
      'deviceid': deviceId,
      'appversion': _appVersion,
      'appbuildnumber': buildNumber ?? _packageInfo?.buildNumber ?? '',
      'authorization': RSAGenerator.generateKey(_appVersion),
    });
    options.contentType = 'application/json';

    final String? deviceToken = await _persistenceService.deviceToken.get();

    //await _tryToOverrideUrl(options);

    if (deviceToken != null) {
      options.headers.addAll(<String, String>{
        'device_token': deviceToken,
      });
    }

    if (!options.headers.containsKey('Content-Type')) {
      options.headers.addAll(<String, String>{
        'Content-Type': 'Request',
      });
    }

    if (options.headers.containsKey(ApiInterceptor.includeDwnToken)) {
      final String? dwnToken = await _persistenceService.dwnToken.get();
      if (dwnToken != null) {
        options.headers.addAll(<String, String>{
          'dwn_token': dwnToken,
          'include-dwn-token': 'true',
        });
      } else {
        options.headers.addAll(<String, String>{
          'include-dwn-token': 'false',
        });
      }
    }

    options.headers
        .addAll(<String, String>{'User-Agent': await _getUserAgent()});

    logger.d('${options.path} ${options.uri}');

    super.onRequest(options, handler);
  }

  /*Future<void> _tryToOverrideUrl(RequestOptions options) async {
    AppConfigurationDataDto? appConfig;
    try {
      // this causes cache issues on app run to be catched when the user comes from a lower version
      // and there are `required` changes on the data models.
      appConfig = await _persistenceService.appConfiguration.get();
    } catch (e) {
      logger.e(e);
    }

    Map<String, String>? dynamicEndpoints = appConfig?.ocsp.endpoints;

    if (dynamicEndpoints != null &&
        options.headers.containsKey(apiDynamicUrl)) {
      String? fullDynamicPath = _getFullDynamicPathFromConfig(
          dynamicEndpoints, options.headers[apiDynamicUrl]);

      if (fullDynamicPath != null) {
        Uri uri = Uri.parse(fullDynamicPath);
        options.baseUrl = uri.origin;

        // Do not remove, this is so there is only one log entry
        String _logs = '[API] Overriding BaseUrl with ${uri.origin}\n';

        String currentPath = options.path;

        if (options.path.startsWith('/')) {
          currentPath = options.path.replaceFirst('/', '');
        }
        String newUpcomingPath = uri.path
            .replaceAll('/\$%7Bversion%7D', '')
            .replaceAll('/%7BproductType%7D', '')
            .replaceAll('/%7Bcategory%7D/%7Buuid%7D', '');

        final int currentPathLength = currentPath.split('/').length;
        final int newUpcomingPathLength =
            newUpcomingPath.replaceFirst('/', '').split('/').length;

        _logs +=
            'PATH COMPARISON current : $currentPath, upcoming : $newUpcomingPath\n';

        int difference = currentPathLength - newUpcomingPathLength;

        _logs += 'Path difference of $difference\n';

        if (difference > 0) {
          int start = currentPathLength - difference;
          final String split = currentPath
              .split('/')
              .sublist(start, currentPathLength)
              .join('/');
          logger.d('Previous Path is longer.. Combining excess.');
          newUpcomingPath = '$newUpcomingPath/$split';
        }

        options.path = newUpcomingPath;

        // final logs
        _logs += '[API] Overriding URL Path with ${options.path}';
        logger.d(_logs);
      }
    }

    options.headers.remove(ApiInterceptor.apiDynamicUrl);
  }*/

  /*String? _getFullDynamicPathFromConfig(
      Map<String, String> endpoints, String key) {
    return endpoints[key];
  }*/

  Future<String> _getUserAgent() async => await userAgent.getUserAgent() ?? '';

  /// Edit this for current platform
  String _currentPlatform() {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'unknown';
    }
  }
}
