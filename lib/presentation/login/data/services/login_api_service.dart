import 'package:dio/dio.dart' hide Headers;
import 'package:mobile_warehouse/presentation/login/data/models/login_response_model.dart';
import 'package:retrofit/http.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: 'http://76.27.84.31:5555')
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String baseUrl}) = _LoginApiService;

  @POST('/userBasicLogin.html?useHdrs=true&uid={uid}&pwd={pwd}')
  Future<String> authenticateUser(
      @Path('uid') String uid, @Path('pwd') String pwd);

  @POST('/userBasicLogin.html')
  Future<LoginResponseModel> login({
    @Field() String? useHdrs,
    @Field() required String uid,
    @Field() required String pwd,
  });
}
