import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'item_lookup_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class ItemLookupApiService {
  factory ItemLookupApiService(Dio dio, {String baseUrl}) =
      _ItemLookupApiService;

  @POST('/mobile(getItemStockList)?useHdrs=true&sessId={token}&itemId={data}')
  Future<dynamic> getItemStockList(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(getItemTrakList)?useHdrs=true&sessId={token}&itemId={data}')
  Future<dynamic> getItemTrakList(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(lookupItemAlias)?useHdrs=true&sessId={token}&alias={data}')
  Future<dynamic> lookupItemAlias(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});
}
