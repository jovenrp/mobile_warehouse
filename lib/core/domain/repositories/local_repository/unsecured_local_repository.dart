import 'dart:convert';

import 'package:mobile_warehouse/core/domain/interfaces/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnsecuredLocalRepository implements LocalRepository {
  UnsecuredLocalRepository(this._prefs);

  // Allows easy mocking for testing
  final SharedPreferences _prefs;

  // * MARK: Default Handlers

  @override
  Future<void> reset() async {
    await _prefs.clear();
    return;
  }

  @override
  Future<void> resetForUser(String? userId) async {
    return;
  }

  @override
  Future<void> removeValue(String? userId, String key) async {
    await _prefs.remove(generateRepoKey(userId, key));
    return;
  }

  // * MARK: String Handler

  @override
  Future<void> saveString(String? userId, String key, String? value) async {
    if (value != null) {
      await _prefs.setString(generateRepoKey(userId, key), value);
    } else {
      await _prefs.remove(generateRepoKey(userId, key));
    }
    return;
  }

  @override
  Future<String?> getString(String? userId, String key) async {
    return _prefs.getString(generateRepoKey(userId, key));
  }

  // * MARK: Bool Handler

  @override
  Future<void> saveBool(String? userId, String key, bool? value) async {
    if (value != null) {
      await _prefs.setBool(generateRepoKey(userId, key), value);
    } else {
      await _prefs.remove(generateRepoKey(userId, key));
    }
    return;
  }

  @override
  Future<bool?> getBool(String? userId, String key) async {
    return _prefs.getBool(generateRepoKey(userId, key));
  }

  // * MARK: Object Handler

  @override
  Future<void> saveObject(
    String? userId,
    String key,
    Map<String, dynamic>? object,
  ) async {
    await _prefs.setString(
        generateRepoKey(userId, key), const JsonEncoder().convert(object));
    return;
  }

  @override
  Future<Map<String, dynamic>?> getObject(String? userId, String key) async {
    final String? stringObject = _prefs.getString(generateRepoKey(userId, key));
    if (stringObject == null) return null;
    return const JsonDecoder().convert(stringObject) as Map<String, dynamic>;
  }

  @override
  Future<void> clearData() async {
    await _prefs.clear();
    return;
  }
}
