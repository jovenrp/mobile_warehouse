import 'dart:io';

import 'package:catcher/core/catcher.dart';
import 'package:catcher/mode/silent_report_mode.dart';
import 'package:catcher/model/catcher_options.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:catcher/model/report.dart';
import 'package:catcher/model/report_handler.dart';
import 'package:catcher/model/report_mode.dart';
import 'package:flutter/material.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application/domain/models/application_config.dart';

const String localizationFileName = 'assets/en.json';
String dirPathBase = '';
String contentBaseUrl = '';
String? appVersion;
String? buildNumber;
// Default is prod
String apiPublicKey = 'api key for prod here';
void commonMain(ApplicationConfig applicationConfig) async {
  // Flutter Optimization
  WidgetsFlutterBinding.ensureInitialized();

  // Set override for appVersion
  appVersion = applicationConfig.appVersion;
  buildNumber = applicationConfig.buildNumber;

  contentBaseUrl = applicationConfig.baseContentUrl;

  apiPublicKey = applicationConfig.apiKey ?? apiPublicKey;

  Catcher(
    rootWidget: Application(
      config: applicationConfig,
      sharedPreferences: await SharedPreferences.getInstance(),
    ),
    debugConfig: CatcherOptions(
      SilentReportMode(),
      <ReportHandler>[
        ConsoleLoggedHandler(),
      ],
    ),
    /* releaseConfig: CatcherOptions(
      SilentReportMode(),
      <ReportHandler>[
        // ConsoleLoggedHandler(),
        EmailAutoHandler(
          'smtp.gmail.com',
          587,
          // Email Sender
          'joven.parola@actiontrak.com',
          // Email Subject
          'ActionTRAK : Error Trace',
          // App Password for SMTP
          'glmrppjikttsctqi',
          // Mailing List
          <String>[
            'joven.parola@actiontrak.com',
          ],
        ),
      ],
    ),*/
  );
}

Future<bool> checkIfLocalizationAssetsIsAvailOnDisk() async {
  String filePath = await localizationFileName.getFilePath();

  return await File(filePath).exists();
}

class LogReportHandler extends ReportMode {
  @override
  void requestAction(Report report, BuildContext? context) {
    logger.e('App Error!\n${report.toJson()}');
    super.onActionConfirmed(report);
  }

  @override
  List<PlatformType> getSupportedPlatforms() =>
      <PlatformType>[PlatformType.web, PlatformType.android, PlatformType.iOS];
}

class ConsoleLoggedHandler extends ReportHandler {
  ConsoleLoggedHandler();

  @override
  Future<bool> handle(Report report, BuildContext? context) {
    String loggedString = '''
============================== CATCHER LOG ==============================
Crash occured on ${report.dateTime}

${_deviceParametersFormatted(report.deviceParameters)}

${_applicationParametersFormatted(report.applicationParameters)}

---------- ERROR ----------
${report.error}

${report.stackTrace != null ? _stackTraceFormatted(report.stackTrace as StackTrace) : null}

${_customParametersFormatted(report.customParameters)}

======================================================================
''';

    logger.wtf(loggedString);

    return Future<bool>.value(true);
  }

  String _deviceParametersFormatted(Map<String, dynamic> deviceParameters) {
    String builder = '------- DEVICE INFO -------';
    for (final MapEntry<String, dynamic> entry in deviceParameters.entries) {
      builder += '\n${entry.key}: ${entry.value}';
    }
    return builder;
  }

  String _applicationParametersFormatted(
      Map<String, dynamic> applicationParameters) {
    String builder = '------- APP INFO -------';
    for (final MapEntry<String, dynamic> entry
        in applicationParameters.entries) {
      builder += '\n${entry.key}: ${entry.value}';
    }
    return builder;
  }

  String _customParametersFormatted(Map<String, dynamic> customParameters) {
    String builder = '------- CUSTOM INFO -------';
    for (final MapEntry<String, dynamic> entry in customParameters.entries) {
      builder += '\n${entry.key}: ${entry.value}';
    }
    return builder;
  }

  String _stackTraceFormatted(StackTrace stackTrace) {
    String builder = '------- STACK TRACE -------';
    for (final String entry in stackTrace.toString().split('\n')) {
      builder += '\n' + entry;
    }
    return builder;
  }

  @override
  List<PlatformType> getSupportedPlatforms() =>
      <PlatformType>[PlatformType.android, PlatformType.iOS, PlatformType.web];
}
