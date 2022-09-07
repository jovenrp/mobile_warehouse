import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'stock_adjust_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class StockAdjustApiService {
  factory StockAdjustApiService(Dio dio, {String baseUrl}) =
      _StockAdjustApiService;

  @POST('/mobile(stockLookUp)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> stockLookup(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(stockAdjustBySku)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> stockAdjust(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});
}
