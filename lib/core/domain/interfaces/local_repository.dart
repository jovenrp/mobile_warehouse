// * Refactor for a per-user basis if needed
abstract class LocalRepository {
  /// Removes all values
  Future<void> reset();

  /// Removes all values
  Future<void> resetForUser(String? userId);

  /// Remove the value from a specific key
  Future<void> removeValue(String? userId, String key);

  Future<void> saveString(String? userId, String key, String? value);
  Future<String?> getString(String? userId, String key);

  Future<void> saveBool(String? userId, String key, bool? value);
  Future<bool?> getBool(String? userId, String key);

  Future<void> clearData();

  // void saveInt(String key, int value);
  // Future<int> getInt(String key);

  Future<void> saveObject(
      String? userId, String key, Map<String, dynamic>? object);
  Future<Map<String, dynamic>?> getObject(String? userId, String key);
}

// * Convenience Method
String generateRepoKey(String? userId, String key) {
  if (userId == null) {
    return key;
  } else {
    return '$userId/$key';
  }
}
