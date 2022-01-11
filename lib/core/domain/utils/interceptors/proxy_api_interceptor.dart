import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:native_flutter_proxy/custom_proxy.dart';
import 'package:native_flutter_proxy/native_proxy_reader.dart';

class ProxyApiInterceptor extends Interceptor {
  ProxyApiInterceptor(this._dio);

  final Dio _dio;

  @override
  Future<dynamic> onRequest(RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) async {
    // ! TODO: Fix issue where proxy can't find method
    // ! MissingPluginException(No implementation found for method getProxySetting on channel native_flutter_proxy)

    try {
      ProxySetting settings = await NativeProxyReader.proxySetting;
      bool enabled = settings.enabled;
      String? host = settings.host;
      int? port = settings.port;

      if (enabled && host != null) {
        final CustomProxy proxy = CustomProxy(ipAddress: host, port: port);
        proxy.enable();

        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient client) {
          client.findProxy = (_) {
            return 'PROXY $host:$port';
          };
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        };
      }
    } catch (e) {
      logger.e(e);
    }

    return super.onRequest(options, requestInterceptorHandler);
  }
}
