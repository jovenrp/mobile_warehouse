import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/login/data/models/login_response_model.dart';
import 'package:mobile_warehouse/presentation/login/data/services/login_api_service.dart';

import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._apiService);

  final LoginApiService _apiService;

  @override
  Future<LoginResponseModel> login(
      {required String username, required String password}) async {
    try {
      String token = await _apiService.authenticateUser(
        username,
        password,
      );

      return LoginResponseModel(token: token, isError: false);
    } catch (_) {
      logger.e(_);
      //Todo Create a proper way to handle login error
      return const LoginResponseModel(
          isError: true,
          errorMessage: 'Wrong username or password entered.',
          token: null);
    }
  }
}
