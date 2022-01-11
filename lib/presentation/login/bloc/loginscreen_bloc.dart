import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_state.dart';
import 'package:mobile_warehouse/presentation/login/data/models/login_response_model.dart';
import 'package:mobile_warehouse/presentation/login/domain/repositories/login_repository.dart';

class LoginScreenBloc extends Cubit<LoginScreenState> {
  LoginScreenBloc({
    required this.loginRepository,
  }) : super(LoginScreenState());

  final LoginRepository loginRepository;

  Future<void> login(String username, String password) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator

    try {
      final LoginResponseModel result = await loginRepository.login(
        username: username,
        password: password,
      );

      print('Result $result');
      emit(state.copyWith(isLoading: false)); //turn off loading indicator
      if (!result.isError) {
        //success
      } else {
        //should be error as token should not be null
      }
    } on DioError catch (_) {
      emit(state.copyWith(isLoading: false)); //turn off loading indicator
    }
  }
}
