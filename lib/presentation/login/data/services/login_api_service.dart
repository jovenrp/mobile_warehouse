import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String baseUrl}) = _LoginApiService;

  @POST('/userBasicLogin.html?useHdrs=true&uid={uid}&pwd={pwd}')
  Future<String> authenticateUser(
      @Path('uid') String uid, @Path('pwd') String pwd);
}
