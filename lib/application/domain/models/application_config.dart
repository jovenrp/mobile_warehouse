class ApplicationConfig {
  ApplicationConfig({
    required this.apiUrl,
    required this.isApiLoggingEnabled,
    required this.isApiDebuggerEnabled,
    required this.isUiDebuggerEnabled,
    this.isProxyEnabled = false,
    required this.baseContentUrl,
    this.apiKey,
    this.appVersion,
    this.buildNumber,
  });

  final String apiUrl;
  final String? apiKey;
  final bool isProxyEnabled;
  final bool isApiLoggingEnabled;
  final bool isApiDebuggerEnabled;
  final bool isUiDebuggerEnabled;
  final String baseContentUrl;
  final String? appVersion;
  final String? buildNumber;
}
