import 'package:package_info/package_info.dart';

abstract class ActionTRAKPlatform {
  Future<PackageInfo> getPackageInfo();
  Future<String> getOsVersion();
  Future<String> getOsName();
  Future<String> getDeviceModel();
  Future<String> getDeviceId();
  Future<String> getManufacturer();
  Future<String> getBrand();
}
