import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'location_mapper_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class LocationMapperApiService {
  factory LocationMapperApiService(Dio dio, {String baseUrl}) =
      _LocationMapperApiService;

  @POST('/mobile(getContainerChildren)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> getContainerChildren(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(getContainer)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> getContainerParent(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(createContainer)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> createContainer(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(getContainerSkus)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> getContainerSkus(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(removeContainerSku)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> removeSku(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(addContainerSku)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> addContainerSku(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(updateContainer)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> updateContainer(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});
}
