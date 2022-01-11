import 'package:dio/dio.dart';
import 'package:mobile_warehouse/core/data/services/utils/api_error_transformer.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/core/domain/models/errors/api_error.dart';
import 'package:mobile_warehouse/presentation/login/data/services/login_api_service.dart';

import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._apiService);

  final LoginApiService _apiService;

  @override
  Future<String> login(
      {required String username, required String password}) async {
    try {
      String token = await _apiService.authenticateUser(
        username,
        password,
      );

      print('here ${token}');

      return token;
    } on DioError catch (e) {
      final ApiServiceException error = ApiErrorTransformer.transform(e);
      final ActionTRAKApiErrorCode? errorCode = error.firstError?.code;

      print('error ${error}');
      rethrow;
    }
  }
}
