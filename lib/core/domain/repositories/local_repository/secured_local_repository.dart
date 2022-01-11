import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/domain/interfaces/local_repository.dart';

class SecuredLocalRepository implements LocalRepository {
  SecuredLocalRepository(this._securedStorage);

  final FlutterSecureStorage _securedStorage;

  // * MARK: Default Handlers

  @override
  Future<void> reset() => _securedStorage.deleteAll();

  @override
  Future<void> resetForUser(String? userId) {
    logger.d('SecuredLocalRepository.resetForUser');
    // DO NOTHING
    return Future<void>.value();
  }

  @override
  Future<void> removeValue(String? userId, String key) =>
      _securedStorage.delete(key: generateRepoKey(userId, key));

  // * MARK: String Handler

  @override
  Future<void> saveString(String? userId, String key, String? value) {
    return _securedStorage.write(
        key: generateRepoKey(userId, key), value: value);
  }

  @override
  Future<String?> getString(String? userId, String key) =>
      _securedStorage.read(key: generateRepoKey(userId, key));

  // * MARK: Bool Handler

  @override
  Future<void> saveBool(String? userId, String key, bool? value) async =>
      _securedStorage.write(
        key: generateRepoKey(userId, key),
        value: (value ?? false) ? 'true' : 'false',
      );

  @override
  Future<bool?> getBool(String? userId, String key) async {
    String? value =
        await _securedStorage.read(key: generateRepoKey(userId, key));
    return Future<bool?>(() {
      if (value == null) {
        return null;
      } else if (value == 'true') {
        return true;
      } else if (value == 'false') {
        return false;
      } else {
        return null;
      }
    });
  }

  // * MARK: Object Handler

  @override
  Future<void> saveObject(
    String? userId,
    String key,
    Map<String, dynamic>? object,
  ) =>
      _securedStorage.write(
        key: generateRepoKey(userId, key),
        value: const JsonEncoder().convert(object),
      );

  @override
  Future<Map<String, dynamic>?> getObject(String? userId, String key) async {
    final String? stringObject =
        await _securedStorage.read(key: generateRepoKey(userId, key));
    if (stringObject == null) {
      return null;
    }
    return const JsonDecoder().convert(stringObject) as Map<String, dynamic>;
  }

  @override
  Future<void> clearData() async => await _securedStorage.deleteAll();
}
