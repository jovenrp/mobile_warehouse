import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';

part 'loginscreen_state.freezed.dart';

@freezed
class LoginScreenState with _$LoginScreenState {
  factory LoginScreenState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    ActionTRAKApiErrorCode? errorCode,
    String? errorMessage,
    @Default(false) bool didFinish,
  }) = _LoginScreenState;
}
