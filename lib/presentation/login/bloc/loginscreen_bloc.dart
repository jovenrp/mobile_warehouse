import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/core/domain/models/user_profile_model.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_state.dart';
import 'package:mobile_warehouse/presentation/login/data/models/login_response_model.dart';
import 'package:mobile_warehouse/presentation/login/domain/repositories/login_repository.dart';

class LoginScreenBloc extends Cubit<LoginScreenState> {
  LoginScreenBloc({
    required this.loginRepository,
    required this.persistenceService,
  }) : super(LoginScreenState());

  final LoginRepository loginRepository;
  final PersistenceService persistenceService;

  Future<void> login(String username, String password) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator

    try {
      final LoginResponseModel result = await loginRepository.login(
        username: username,
        password: password,
      );

      emit(state.copyWith(
          isLoading: false,
          hasError: result.isError)); //turn off loading indicator
      if (!result.isError) {
        //success
        await persistenceService.dwnToken.set(result.token);
        await persistenceService.userProfile
            .set(UserProfileModel(username: username).toJson());
        emit(state.copyWith(loginResponseModel: result));
      } else {
        //should be error as token should not be null
        emit(state.copyWith(loginResponseModel: result)); //
      }
    } on DioError catch (_) {
      emit(state.copyWith(isLoading: false)); //turn off loading indicator
    }
  }

  Future<void> forgotPassword() async {}
}
