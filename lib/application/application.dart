import 'dart:async';

import 'package:alice_lightweight/alice.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;
import 'package:logger/logger.dart';
import 'package:mobile_warehouse/application/providers/blocs_provider.dart';
import 'package:mobile_warehouse/application/providers/repositories_provider.dart';
import 'package:mobile_warehouse/application/theme.dart';
import 'package:mobile_warehouse/core/data/services/api_service.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/core/data/services/utils/flutter_user_agent.dart';
import 'package:mobile_warehouse/core/domain/models/errors/api_error.dart';
import 'package:mobile_warehouse/core/domain/repositories/local_repository/memory_repository.dart';
import 'package:mobile_warehouse/core/domain/repositories/local_repository/secured_local_repository.dart';
import 'package:mobile_warehouse/core/domain/repositories/local_repository/unsecured_local_repository.dart';
import 'package:mobile_warehouse/core/domain/utils/interceptors/api_interceptor.dart';
import 'package:mobile_warehouse/core/domain/utils/interceptors/proxy_api_interceptor.dart';
import 'package:mobile_warehouse/core/domain/utils/platform/actiontrak_platform_impl.dart';
import 'package:mobile_warehouse/core/presentation/widgets/theme_state.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/splash/presentation/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/bloc/application_bloc.dart';
import 'domain/bloc/application_state.dart';
import 'domain/models/application_config.dart';

Logger logger = Logger(
  filter: ProductionFilter(),
  printer: PrettyPrinter(),
  output: ConsoleOutput(),
);

class Application extends StatefulWidget {
  const Application({
    Key? key,
    required this.config,
    required this.sharedPreferences,
  }) : super(key: key);

  final ApplicationConfig config;
  final SharedPreferences sharedPreferences;

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late ThemeState themeState;

  late Dio _dio;
  late PersistenceService _persistenceService;
  bool _showingRequiredUpdate = false;
  bool _showingServiceUnavailable = false;
  bool _loggerIsVisible = false;
  //bool _showingNoInternetError = false;
  //bool _sessionExpiredIsVisible = false;
  late ApplicationBloc _appBloc;
  late ApiService _apiService;

  // Expose, context from this key can be safely used for dialogs
  late GlobalKey<NavigatorState> navigatorKey;
  late ShakeDetector detector;
  Alice? globalAlice;

  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey<NavigatorState>();
    _loggerIsVisible = false;
    _showingRequiredUpdate = false;
    _showingServiceUnavailable = false;
    //_showingNoInternetError = false;
    //_sessionExpiredIsVisible = false;

    themeState = getThemeState(
      false,
      darkTheme(),
      lightTheme(),
    );

    _persistenceService = PersistenceService(
      SecuredLocalRepository(const fss.FlutterSecureStorage()),
      UnsecuredLocalRepository(widget.sharedPreferences),
      MemoryRepository(),
    );

    _dio = _createDioInstance(
      persistenceService: _persistenceService,
      isApiLoggingEnabled: widget.config.isApiLoggingEnabled,
      isApiDebuggerEnabled: widget.config.isApiDebuggerEnabled,
      config: widget.config,
    );

    _appBloc = ApplicationBloc();
    _apiService = ApiService(dio: _dio);

    if (widget.config.isUiDebuggerEnabled) {
      navigatorKey = globalAlice?.getNavigatorKey() ?? navigatorKey;
      detector = ShakeDetector.autoStart(onPhoneShake: () {
        _showLoggers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<SingleChildWidget> repositories = RepositoriesProvider.provide(
        dio: _dio,
        apiUrl: widget.config.apiUrl,
        actionTRAKApiService: _apiService.actionTRAKApiService);

    final List<SingleChildWidget> blocs = BlocsProvider.provide(
      dio: _dio,
      apiUrl: widget.config.apiUrl,
      persistenceService: _persistenceService,
      appBloc: _appBloc,
      navigatorKey: navigatorKey,
    );

    List<SingleChildWidget> services = <SingleChildWidget>[
      Provider<PersistenceService>.value(value: _persistenceService),
      Provider<ApiService>.value(value: _apiService),
    ];

    List<SingleChildWidget> providers = <SingleChildWidget>[
      ...repositories,
      ...blocs,
      ...services,
    ];

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiProvider(
        providers: providers,
        child: BlocConsumer<ApplicationBloc, ApplicationState>(
          listener: (BuildContext context, ApplicationState state) {
            // Handle
          },
          builder: (BuildContext context, __) => MaterialApp(
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              I18n.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: I18n.delegate.supportedLocales,
            localeResolutionCallback: I18n.delegate.resolution(
              fallback: const Locale('en', 'US'),
            ),
            theme: themeState.theme,
            darkTheme: themeState.themeDark,
            themeMode: ThemeMode.dark,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: I18n.of(context).application_name,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}

extension ApplicationApiInterceptors on _ApplicationState {
  void _showLoggers() {
    if (_loggerIsVisible) return;
    _loggerIsVisible = true;

    BuildContext? context = navigatorKey.currentContext;

    if (context != null) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('ActionTRAK'),
          message: const Text('Show Logs'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                _loggerIsVisible = false;
                globalAlice?.showInspector();
              },
              child: const Text('Show API Logs'),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                _loggerIsVisible = false;
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    }
  }

  Dio _createDioInstance({
    required PersistenceService persistenceService,
    required bool isApiDebuggerEnabled,
    required bool isApiLoggingEnabled,
    required ApplicationConfig config,
  }) {
    final Dio dio = Dio();

    dio.interceptors.clear();

    if (widget.config.isProxyEnabled) {
      dio.interceptors.add(ProxyApiInterceptor(dio));
    }

    dio.interceptors.add(ApiInterceptor(
      persistenceService,
      appVersion: config.appVersion,
      buildNumber: config.buildNumber,
      userAgent: ActionTRAKFlutterUserAgent(),
      gomoPlatform: ActionTRAKPlatformImpl(),
      onForbiddenException: _handleForbiddenException,
      onRequiredUpdateError: _handleRequiredUpdateError,
      onServiceUnavailableError: _handleServiceUnavailableError,
      onUnauthenticatedError: _handleUnauthenticatedError,
      onApiDeprecationError: _handleApiDeprecationError,
      onNoInternetError: _handleNoInternetError,
    ));

    dio.interceptors.add(RetryInterceptor(
      options: RetryOptions(
          retries: 3, // Number of retries before a failure
          retryInterval:
              const Duration(seconds: 10), // Interval between each retry
          retryEvaluator: (DioError error) {
            return error.response?.statusCode == 429;
          }),
      dio: dio,
    ));

    if (isApiLoggingEnabled) {
      dio.interceptors.add(HttpFormatter(logger: logger));
    }

    return dio;
  }
}

extension ApplicationApiErrorHandling on _ApplicationState {
  Future<dynamic> _handleNoInternetError(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    final Completer<Response<dynamic>> responseCompleter =
        Completer<Response<dynamic>>();

    //final BuildContext? context = navigatorKey.currentContext;

    //Comment out and add no internet dialog
    /*if (context != null) {
      _appBloc.setIsNetworkError(false);
      if (!showingNoInternetError) {
        setShowingNoInternetError(true);
        _appBloc.setIsNetworkError(true);

        DialogUtils.showNoInternetConnection(context, negativeAction: () {
          _appBloc.setIsNetworkError(false);
          _appBloc.setIsNetworkError(true);
          responseCompleter.complete(Future<Response<dynamic>>.error(
              SocketException('No Connection')));
          setShowingNoInternetError(false);
        }, positiveAction: () {
          _appBloc.setIsNetworkError(false);
          responseCompleter.complete(
            _dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
            ),
          );

          setShowingNoInternetError(false);
        });
      }
    }*/
    return responseCompleter.future;
  }

  void _handleForbiddenException(ForbiddenException? exception) {
    final String title = exception?.errorData?.title ?? 'Forbidden messages';
    final String description = exception?.errorData?.description ??
        'You do not have access resource for now';

    // TODO: Forbidden Error
    logger.d(title);
    logger.d(description);
  }

  void _handleRequiredUpdateError(RequiredUpdateException exception) {
    BuildContext? context = navigatorKey.currentContext;
    if (!_showingRequiredUpdate && context != null) {
      /*String? errorTitle = exception.errorData?.title;
      String? errorMessage = exception.errorData?.description;
      //Uncomment and redirect to update app screen
      Navigator.of(context, rootNavigator: true).push(
        UpdateRequiredScreen.route(title: errorTitle, message: errorMessage),
      );*/
      _showingRequiredUpdate = true;
      return;
    }
  }

  void _handleServiceUnavailableError(ServiceUnavailableException exception) {
    final BuildContext? context = navigatorKey.currentContext;
    if (!_showingServiceUnavailable && context != null) {
      /*final String? title = exception.errorData?.title ??
          I18n.of(context).server_message__forbidden__title;
      final String? description = exception.errorData?.description ??
          I18n.of(context).server_message__forbidden__supporting_text;

      _showingServiceUnavailable = true;

      //Comment out and redirect to maintenance screen
      Navigator.of(context, rootNavigator: true).push(
        MaintenanceScreen.route(title: title, message: description),
      );*/

      _showingServiceUnavailable = false;
    }
  }

  void _handleUnauthenticatedError(
    UnauthorizedException exception,
  ) async {
    /*if (exception.originalException is! DioError) {
      return;
    }
    final BuildContext context = navigatorKey.currentContext ?? this.context;
    final ActionTRAKApiError? error = exception.firstError;
    String? message = '';
    String title =
        I18n.of(context).authentication_message__after_changed_pin__title;
    if (<ActionTRAKApiErrorCode>[
      ActionTRAKApiErrorCode.api101,
      ActionTRAKApiErrorCode.api099,
      ActionTRAKApiErrorCode.api098,
      ActionTRAKApiErrorCode.api145
    ].contains(error?.code)) {
      if (error?.code == ActionTRAKApiErrorCode.api098) {
        title = I18n.of(context).toast__authentication__auto_log_out__title;
        message = I18n.of(context).error_messages__api_098;
      } else if (error?.code == ActionTRAKApiErrorCode.api145) {
        message = I18n.of(context).error_messages__api_145;
      } else {
        message = error?.message;
      }
    }

    await _persistenceService.logout();
    if (_sessionExpiredIsVisible) return;
    _sessionExpiredIsVisible = true;

    if (await canShowExpiredTokenDialog(context)) return;

    //Comment out and show relogin dialog
    DialogUtils.showSingleButtonDialog(
      context,
      title: title,
      message: message ?? '',
      buttonText: 'Log In',
      toDismiss: false,
      action: () {
        Navigator.of(context, rootNavigator: true).popUntil((_) => true);
        PinFlowCoordinator.startLoginFlow(context);
        _sessionExpiredIsVisible = false;
      },
    );*/
  }

  Future<bool> canShowExpiredTokenDialog(BuildContext? context) async {
    if ((await context?.read<PersistenceService>().temporaryUserId.get()) !=
        null) return false;
    return true;
  }

  void _handleApiDeprecationError(DeprecationException error) {}
}
