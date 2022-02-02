import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  factory ForgotPasswordState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool hasError,
    ActionTRAKApiErrorCode? errorCode,
    String? errorMessage,
    @Default(false) bool didFinish,
  }) = _ForgotPasswordState;
}
