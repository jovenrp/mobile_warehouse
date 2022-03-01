import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_config.g.dart';

@JsonSerializable()
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

  factory ApplicationConfig.fromJson(Map<String, dynamic> json) =>
      _$ApplicationConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationConfigToJson(this);

  static ApplicationConfig? fromJsonX(Map<String, dynamic>? json) =>
      json == null ? null : ApplicationConfig.fromJson(json);

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
