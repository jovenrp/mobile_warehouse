import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: 'http://76.27.84.31:5555')
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String baseUrl}) = _LoginApiService;

  @POST('/userBasicLogin.html?useHdrs=true&uid={uid}&pwd={pwd}')
  Future<String> authenticateUser(
      @Path('uid') String uid, @Path('pwd') String pwd);
}
