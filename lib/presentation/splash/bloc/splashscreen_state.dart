import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';

part 'splashscreen_state.freezed.dart';

@freezed
class SplashScreenState with _$SplashScreenState {
  factory SplashScreenState({
    String? pinError,
    // * View Flags
    @Default(false) bool isLoading,
    @Default(false) bool didAgreeToTerms,
    @Default(false) bool hasError,
    ActionTRAKApiErrorCode? errorCode,
    String? errorMessage,
    @Default(false) bool didFinish,
  }) = _SplashScreenState;
}
