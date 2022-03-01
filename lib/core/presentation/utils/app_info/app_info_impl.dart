import 'package:package_info/package_info.dart';
import 'app_info.dart';

class AppInfoImpl implements AppInfo {
  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  String? appName;

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  String? packageName;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  String? version;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  String? buildNumber;

  static PackageInfo? _instance;

  static Future<String> _getAppVersion() async {
    _instance ??= await PackageInfo.fromPlatform();
    return _instance!.version.split('.').take(3).join('.');
  }

  static Future<String> _getBuildNumber() async {
    _instance ??= await PackageInfo.fromPlatform();
    return _instance!.buildNumber;
  }

  @override
  Future<String> appBuildNumber() async {
    return await _getBuildNumber();
  }

  @override
  Future<String> appVersion() async {
    return await _getAppVersion();
  }
}
