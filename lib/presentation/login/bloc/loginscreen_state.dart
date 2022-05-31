import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/core/domain/models/user_profile_model.dart';
import 'package:mobile_warehouse/presentation/login/data/models/login_response_model.dart';

part 'loginscreen_state.freezed.dart';

@freezed
class LoginScreenState with _$LoginScreenState {
  factory LoginScreenState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      String? apiUrl,
      @Default(false) bool isLoggedIn,
      @Default(false) bool didFinish,
      LoginResponseModel? loginResponseModel,
      UserProfileModel? userProfileModel}) = _LoginScreenState;
}
