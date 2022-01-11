import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class DeviceInfo {
  DeviceInfo._internal({
    required this.osName,
    required this.osVersion,
    required this.deviceModel,
    required this.deviceID,
    required this.manufacturer,
    required this.brand,
  });

  final String osName;
  final String osVersion;
  final String deviceModel;
  final String deviceID;
  final String manufacturer;
  final String brand;

  static DeviceInfo? _instance;

  static Future<DeviceInfo> info() async {
    if (_instance != null) {
      return _instance!;
    }

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        _instance = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _instance = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      _instance = DeviceInfo._internal(
          osName: 'Uknown',
          osVersion: 'Uknown',
          deviceModel: 'Uknown',
          deviceID: 'Uknown',
          manufacturer: 'Uknown',
          brand: 'Uknown');
    }

    return _instance!;
  }

  static DeviceInfo _readAndroidBuildData(AndroidDeviceInfo build) {
    return DeviceInfo._internal(
      osName: 'Android',
      osVersion: build.version.release,
      deviceModel: build.model,
      deviceID: build.androidId,
      manufacturer: build.manufacturer,
      brand: build.brand,
    );
  }

  static DeviceInfo _readIosDeviceInfo(IosDeviceInfo data) {
    return DeviceInfo._internal(
      osName: 'iOS',
      osVersion: data.systemVersion,
      deviceModel: data.model,
      deviceID: data.identifierForVendor,
      manufacturer: 'Apple',
      brand: 'Apple',
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'osName': osName,
        'osVersion': osVersion,
        'deviceModel': deviceModel,
        'deviceID': deviceID,
        'manufacturer': manufacturer,
        'brand': brand,
      };
}
