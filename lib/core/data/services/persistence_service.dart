import 'package:mobile_warehouse/core/domain/interfaces/local_repository.dart';
import 'package:mobile_warehouse/core/domain/models/persistence_value_container.dart';

class PersistenceService {
  PersistenceService(
    this._securedStorage,
    this._unsecuredStorage,
    this._memoryStorage,
  );

  final LocalRepository _securedStorage;
  final LocalRepository _unsecuredStorage;
  final LocalRepository _memoryStorage;

  /// For Manual Object Saving
  LocalRepository get secured => _securedStorage;
  LocalRepository get unsecured => _unsecuredStorage;
  LocalRepository get memory => _memoryStorage;

  /// Use this to reset persistence for all users
  Future<void> logout() async {
    await currentUserServiceNumber.removeData();
    await dwnToken.removeData();
    //await userProfile.removeData();
    //await userEmailVerification.removeData();
  }

  Future<void> resetBiometrics() async {
    await isBiometricsEnabled.removeData();
    await userPin.removeData();
  }

  Future<void> reset() async {
    await _securedStorage.reset();
    await _unsecuredStorage.reset();
    await _memoryStorage.reset();

    // So that even in app cache reset this will not change
    await isAppInstalled.set(true);
  }

  /// Use this to reset persistence specifically for a specific user
  Future<void> resetForUser(String userId) async {
    await _securedStorage.resetForUser(userId);
    await _unsecuredStorage.resetForUser(userId);
    await _memoryStorage.resetForUser(userId);

    // So that even in app cache reset this will not change
    await isAppInstalled.set(true);
  }

  Future<void> removeFirstTimeLogin() async {
    await isFirstTimeLogin.set(false);
  }

  // ! Persistence

  StringValueContainer get currentUserServiceNumber => StringValueContainer(
        'keys.currentUserId',
        _securedStorage,
      );

  ///Storage for displaying data in pin screen
  ///this data will also be used for checking in splash screen
  ///checking if user will redirect to landing screen or to pin screen
  StringValueContainer get temporaryUserId => StringValueContainer(
        'keys.temporaryUserId',
        _unsecuredStorage,
      );

  StringValueContainer get dwnToken => StringValueContainer(
        'keys.dwnToken',
        _securedStorage,
      );

  StringValueContainer get deviceToken => StringValueContainer(
        'keys.deviceToken',
        _unsecuredStorage,
      );

  StringValueContainer get userPin => StringValueContainer(
        'keys.userPin',
        _securedStorage,
      );

  BoolValueContainer get isBiometricsEnabled => BoolValueContainer(
        'keys.isBiometricsEnabled',
        _securedStorage,
      );

  BoolValueContainer get isFirstTimeLogin => BoolValueContainer(
        'keys.isFirstTimeLogin',
        _unsecuredStorage,
      );

  // Will return false if app has not been runned yet
  // Logic is placed in splash_bloc.dart
  BoolValueContainer get isAppInstalled => BoolValueContainer(
        'keys.isAppInstalled',
        _unsecuredStorage,
      );

  BoolValueContainer get isEyeGuideFinished => BoolValueContainer(
        'keys.isAppFreshInstalled',
        _unsecuredStorage,
        serviceNumber: currentUserServiceNumber.get,
      );

  BoolValueContainer get isFirstTimeUnli => BoolValueContainer(
        'keys.isFirstTimeUnli',
        _unsecuredStorage,
      );

  BoolValueContainer get isFirstTimeAllUnli => BoolValueContainer(
        'keys.isFirstTimeAllUnli',
        _unsecuredStorage,
      );

  /// This is the flag used for Dawn Migration
  BoolValueContainer get isDawnMigrationCompleted => BoolValueContainer(
        'keys.isMigrationCompleted',
        _unsecuredStorage,
      );

  BoolValueContainer get hasUnreadMessage => BoolValueContainer(
        'keys.hasUnreadMessage',
        _unsecuredStorage,
      );

  /*ObjectValueContainer<AppConfigurationDataDto> get appConfiguration =>
      ObjectValueContainer<AppConfigurationDataDto>(
        'keys.appConfiguration',
        _securedStorage,
        AppConfigurationDataDto.fromJsonX,
      );*/

  Future<int> getLastRefresh() async {
    String? userId = await currentUserServiceNumber.get();
    String? timeStampString =
        await memory.getString(userId, 'keys.home.lastRefresh');
    return int.parse(timeStampString ?? '-1');
  }

  Future<void> updateLastRefresh() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    String? userId = await currentUserServiceNumber.get();
    await memory.saveString(userId, 'keys.mocreds.lastRefresh', now.toString());
  }

  BoolValueContainer get displayBanner => BoolValueContainer(
        'keys.home.displayBanner',
        memory,
      );

  BoolValueContainer get hasDismissedUnliDataBanner => BoolValueContainer(
        'keys.home.hasDismissedUnliDataBanner',
        unsecured,
      );

  BoolValueContainer get hasStartedAppDynamics => BoolValueContainer(
        'keys.hasStartedAppDynamics',
        _memoryStorage,
      );

  Future<void> updateHomeLastRefresh() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    String? userId = await currentUserServiceNumber.get();
    await memory.saveString(userId, 'keys.home.lastRefresh', now.toString());
  }
}
