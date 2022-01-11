import 'dart:async';

import 'package:mobile_warehouse/core/domain/interfaces/local_repository.dart';

typedef GetUserBlock = FutureOr<String?> Function();

abstract class PersistenceValueContainer {
  const PersistenceValueContainer(this.key, this.storage, {this.serviceNumber});

  final LocalRepository storage;
  final GetUserBlock? serviceNumber;
  final String key;

  Future<void> removeData();
}

class BoolValueContainer implements PersistenceValueContainer {
  const BoolValueContainer(this.key, this.storage, {this.serviceNumber});

  @override
  final LocalRepository storage;

  @override
  final GetUserBlock? serviceNumber;

  @override
  final String key;

  Future<bool?> get() async =>
      storage.getBool(await serviceNumber?.call(), key);

  Future<void> set(bool? value) async =>
      storage.saveBool(await serviceNumber?.call(), key, value);

  @override
  Future<void> removeData() async =>
      await storage.removeValue(await serviceNumber?.call(), key);
}

class StringValueContainer implements PersistenceValueContainer {
  const StringValueContainer(this.key, this.storage, {this.serviceNumber});

  @override
  final LocalRepository storage;

  @override
  final GetUserBlock? serviceNumber;

  @override
  final String key;

  Future<String?> get() async =>
      storage.getString(await serviceNumber?.call(), key);

  Future<void> set(String? value) async =>
      storage.saveString(await serviceNumber?.call(), key, value);

  @override
  Future<void> removeData() async =>
      await storage.removeValue(await serviceNumber?.call(), key);
}

// class IntValueContainer implements PersistenceValueContainer {
//   const IntValueContainer(this.key, this.storage, {this.userId});

//   @override
//   final LocalRepository storage;

//   @override
//   final GetUserBlock? userId;

//   @override
//   final String key;

//   Future<int> get() => storage.getInt(userId, key);

//   Future<void> set(int value) async => storage.saveInt(await userId, key, value);
// }

// class DoubleValueContainer implements PersistenceValueContainer {
//   const DoubleValueContainer(this.key, this.storage, {this.userId});

//   @override
//   final LocalRepository storage;

//   @override
//   final GetUserBlock? userId;

//   @override
//   final String key;

//   Future<double> get() => storage.getDouble(userId, key);

//   Future<void> set(double value) async => storage.saveDouble(await userId, key, value);
// }

typedef ObjectValueContainerConverter<T> = T? Function(Map<String, dynamic>?);

class ObjectValueContainer<T> implements PersistenceValueContainer {
  const ObjectValueContainer(this.key, this.storage, this.converter,
      {this.serviceNumber});

  @override
  final LocalRepository storage;

  @override
  final GetUserBlock? serviceNumber;

  @override
  final String key;

  final ObjectValueContainerConverter<T> converter;

  Future<T?> get() async {
    final Map<String, dynamic>? json =
        await storage.getObject(await serviceNumber?.call(), key);
    if (json == null) return null;

    return converter(json);
  }

  Future<void> set(Map<String, dynamic>? value) async =>
      storage.saveObject(await serviceNumber?.call(), key, value);

  @override
  Future<void> removeData() async =>
      await storage.removeValue(await serviceNumber?.call(), key);
}
