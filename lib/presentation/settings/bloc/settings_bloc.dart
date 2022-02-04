import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/settings/bloc/settings_state.dart';

class SettingsScreenBloc extends Cubit<SettingsScreenState> {
  SettingsScreenBloc({
    required this.persistenceService,
  }) : super(SettingsScreenState());

  final PersistenceService persistenceService;

  Future<void> checkSettings() async {
    emit(state.copyWith(isLoading: true));

    bool pickLimitSetting =
        await persistenceService.pickLimitSetting.get() ?? false;
    emit(state.copyWith(isLoading: false, pickLimitSetting: pickLimitSetting));
  }

  Future<void> togglePickLimitSetting(bool value) async {
    await persistenceService.pickLimitSetting.set(value);
  }
}
