import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsScreenState with _$SettingsScreenState {
  factory SettingsScreenState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      bool? pickLimitSetting,
      String? appVersion,
      String? url,
      @Default(false) bool didFinish}) = _SettingsScreenState;
}
