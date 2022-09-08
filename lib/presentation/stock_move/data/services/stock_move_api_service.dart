import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'stock_move_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class StockMoveApiService {
  factory StockMoveApiService(Dio dio, {String baseUrl}) = _StockMoveApiService;

  @POST(
      '/mobile(stockYield)?useHdrs=true&sessId={token}&sourceStockId={sourceStockId}&destContainerId={destContainerId}&qty={qty}')
  Future<dynamic> stockYield(@Path('token') String? token,
      {@Path('headers') String? headers,
      @Path('sourceStockId') String? sourceStockId,
      @Path('destContainerId') String? destContainerId,
      @Path('qty') String? qty});

  @POST('/mobile(stockYield)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> stockYieldBySku(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(getContainers)?useHdrs=true&sessId={token}')
  Future<dynamic> getContainers(@Path('token') String? token,
      {@Path('headers') String? headers});
}
