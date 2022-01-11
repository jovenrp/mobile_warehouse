import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'actiontrak_api_service.g.dart';

@RestApi(baseUrl: 'https://api.gomo.ph/')
abstract class ActionTRAKApiService {
  factory ActionTRAKApiService(Dio dio, {String baseUrl}) =
      _ActionTRAKApiService;

  // * |-------------------------------
  // * |--- APPCONFIGURATION ----------
  // * |-------------------------------

  //get app configuration version
  /*@POST('appconfiguration/{version}')
  Future<MobileAppConfigurationResponseDto> mobileAppConfiguration(
    @Path() String version,
  );*/

  // * |-------------------------------
  // * |--- AUTHENTICATION ------------
  // * |-------------------------------

  /*@POST('authentication/v1/verify-service-number')
  @Headers(<String, dynamic>{
    ApiInterceptor.apiDynamicUrl: DynamicApiKeys.verifyServiceNumber,
  })
  Future<BaseApiResponseDto> login(
    @Field() String uid,
    @Field() String pwd,
  );*/
}
