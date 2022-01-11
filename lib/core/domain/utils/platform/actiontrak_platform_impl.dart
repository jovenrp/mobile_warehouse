import 'package:mobile_warehouse/core/presentation/utils/device_info.dart';
import 'package:package_info/package_info.dart';
import 'actiontrak_platform.dart';

class ActionTRAKPlatformImpl implements ActionTRAKPlatform {
  DeviceInfo? _deviceInfo;

  Future<DeviceInfo> _getDeviceInfo() async {
    return _deviceInfo ??= await DeviceInfo.info();
  }

  @override
  Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Future<String> getBrand() async {
    return (await _getDeviceInfo()).brand;
  }

  @override
  Future<String> getDeviceId() async {
    return (await _getDeviceInfo()).deviceID;
  }

  @override
  Future<String> getDeviceModel() async {
    return (await _getDeviceInfo()).deviceModel;
  }

  @override
  Future<String> getManufacturer() async {
    return (await _getDeviceInfo()).manufacturer;
  }

  @override
  Future<String> getOsName() async {
    return (await _getDeviceInfo()).osName;
  }

  @override
  Future<String> getOsVersion() async {
    return (await _getDeviceInfo()).osVersion;
  }
}
