import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'stock_adjust_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class StockAdjustApiService {
  factory StockAdjustApiService(Dio dio, {String baseUrl}) =
      _StockAdjustApiService;

  @POST(
      '/mobile(stockAdjust)?useHdrs=true&sessId={token}&stockId={stockId}&qty={qty}&absolute={absolute}')
  Future<dynamic> stockAdjust(@Path('token') String? token,
      {@Path('headers') String? headers,
      @Path('stockId') String? stockId,
      @Path('qty') String? qty,
      @Path('absolute') bool? absolute});
}
