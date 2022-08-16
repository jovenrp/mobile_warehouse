import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'container_move_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class ContainerMoveApiService {
  factory ContainerMoveApiService(Dio dio, {String baseUrl}) =
      _ContainerMoveApiService;

  @POST(
      '/mobile(containerMoveApiService)?useHdrs=true&sessId={token}&stockId={stockId}&qty={qty}&absolute={absolute}')
  Future<dynamic> containerMoveApiService(@Path('token') String? token,
      {@Path('headers') String? headers,
      @Path('stockId') String? stockId,
      @Path('qty') String? qty,
      @Path('absolute') bool? absolute});
}
