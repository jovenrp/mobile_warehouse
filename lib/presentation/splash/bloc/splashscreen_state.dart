import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/core/domain/models/user_profile_model.dart';

part 'splashscreen_state.freezed.dart';

@freezed
class SplashScreenState with _$SplashScreenState {
  factory SplashScreenState({
    String? pinError,
    // * View Flags
    @Default(false) bool isLoading,
    @Default(false) bool isAlreadySignedIn,
    @Default(false) bool hasError,
    ActionTRAKApiErrorCode? errorCode,
    String? errorMessage,
    String? apiUrl,
    @Default(false) bool didFinish,
    UserProfileModel? userProfileModel,
    String? token,
  }) = _SplashScreenState;
}
