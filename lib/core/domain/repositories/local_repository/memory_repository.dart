import 'package:mobile_warehouse/core/domain/interfaces/local_repository.dart';

/// Repository that is usable to maintain Global States and Flags
/// Data here are only stored over a runtime and is cleared upon app close
class MemoryRepository extends LocalRepository {
  // * Note this needs to be a singleton
  factory MemoryRepository() {
    return _singleton;
  }

  MemoryRepository._internal();

  static final MemoryRepository _singleton = MemoryRepository._internal();

  final Map<String, Map<String, dynamic>> _memoryMap =
      <String, Map<String, dynamic>>{};

  @override
  Future<void> clearData() {
    _memoryMap.clear();
    return Future<void>.value();
  }

  @override
  Future<bool?> getBool(String? userId, String key) async {
    if (_memoryMap.containsKey(userId)) {
      return _memoryMap[userId ?? '']?[key];
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> getObject(String? userId, String key) async {
    if (_memoryMap.containsKey(userId)) {
      return _memoryMap[userId ?? '']?[key];
    }
    return null;
  }

  @override
  Future<String?> getString(String? userId, String key) async {
    if (_memoryMap.containsKey(userId)) {
      return _memoryMap[userId ?? '']?[key];
    }
    return null;
  }

  @override
  Future<void> removeValue(String? userId, String key) async {
    if (_memoryMap.containsKey(userId)) {
      _memoryMap[userId ?? '']?.remove(key);
    }
    return Future<void>.value();
  }

  @override
  Future<void> reset() {
    _memoryMap.clear();
    return Future<void>.value();
  }

  @override
  Future<void> resetForUser(String? userId) {
    if (_memoryMap.containsKey(userId)) {
      _memoryMap[userId ?? '']?.clear();
    }
    return Future<void>.value();
  }

  @override
  Future<void> saveBool(String? userId, String key, bool? value) {
    _initializeMapForUserIfNeeded(userId);
    _memoryMap[userId ?? '']?[key] = value;
    return Future<void>.value();
  }

  @override
  Future<void> saveObject(
      String? userId, String key, Map<String, dynamic>? object) {
    _initializeMapForUserIfNeeded(userId);
    _memoryMap[userId ?? '']?[key] = object;
    return Future<void>.value();
  }

  @override
  Future<void> saveString(String? userId, String key, String? value) {
    _initializeMapForUserIfNeeded(userId);
    _memoryMap[userId ?? '']?[key] = value;
    return Future<void>.value();
  }

  void _initializeMapForUserIfNeeded(String? user) {
    final String usr = user ?? '';
    if (_memoryMap.containsKey(usr)) {
      return;
    }
    _memoryMap[usr] = <String, dynamic>{};
  }
}
