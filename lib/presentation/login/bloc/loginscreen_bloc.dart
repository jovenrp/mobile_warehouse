import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_state.dart';
import 'package:mobile_warehouse/presentation/login/domain/repositories/login_repository.dart';

class LoginScreenBloc extends Cubit<LoginScreenState> {
  LoginScreenBloc({
    required this.loginRepository,
  }) : super(LoginScreenState());

  final LoginRepository loginRepository;

  Future<void> login(String username, String password) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator

    try {
      final String result = await loginRepository.login(
        username: username,
        password: password,
      );

      emit(state.copyWith(isLoading: false)); //turn off loading indicator
      if (result != '') {
        //success
      } else {
        //should be error as token should not be null
      }
    } on DioError catch (e) {
      emit(state.copyWith(isLoading: false)); //turn off loading indicator
    }
  }
}
