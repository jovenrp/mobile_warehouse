import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/domain/models/application_config.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/settings/bloc/settings_state.dart';
import 'package:package_info/package_info.dart';

class SettingsScreenBloc extends Cubit<SettingsScreenState> {
  SettingsScreenBloc({
    required this.persistenceService,
  }) : super(SettingsScreenState());

  final PersistenceService persistenceService;

  Future<void> checkSettings() async {
    emit(state.copyWith(isLoading: true));

    ApplicationConfig? config = await persistenceService.appConfiguration.get();
    String? url = await persistenceService.preferredApi.get();

    emit(state.copyWith(appVersion: config?.appVersion, url: url?.isNotEmpty == true ? url : config?.apiUrl));

    bool pickLimitSetting =
        await persistenceService.pickLimitSetting.get() ?? false;

    emit(state.copyWith(isLoading: false, pickLimitSetting: pickLimitSetting));
  }

  Future<void> togglePickLimitSetting(bool value) async {
    await persistenceService.pickLimitSetting.set(value);
  }

  Future<void> getAppVersion() async {
    PackageInfo? _instance;
    _instance ??= await PackageInfo.fromPlatform();
    print('${_instance.version.split('.').take(3).join('.')}');
    emit(state.copyWith(
        appVersion: _instance.version.split('.').take(3).join('.')));
  }

  Future<bool> updateApi(String? api) async {
    await persistenceService.preferredApi.set(api);

    ApplicationConfig? config = await persistenceService.appConfiguration.get();
    print('${config?.apiUrl} $api');
    if (config?.apiUrl != api && api?.isNotEmpty == true) {
      emit(state.copyWith(appVersion: config?.appVersion, url: api?.isNotEmpty == true ? api : config?.apiUrl));
      return true;
    } else {
      return false;
    }
  }
}
