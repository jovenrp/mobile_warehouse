import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_state.freezed.dart';

@freezed
class ApplicationState with _$ApplicationState {
  factory ApplicationState({
    @Default('') String deviceNotificationToken,
    @Default(false) bool isNetworkError,
  }) = _ApplicationState;
}
