import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';

part 'dashboardscreen_state.freezed.dart';

@freezed
class DashboardScreenState with _$DashboardScreenState {
  factory DashboardScreenState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    ActionTRAKApiErrorCode? errorCode,
    String? errorMessage,
    @Default(false) bool didFinish,
    @Default(false) bool isSignedOut,
  }) = _DashboardScreenState;
}
