import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'ship_tickets_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class ShipTicketsApiService {
  factory ShipTicketsApiService(Dio dio, {String baseUrl}) =
      _ShipTicketsApiService;

  @POST('/mobile(getShipTickets)?useHdrs=true&sessId={token}')
  Future<dynamic> getShipTickets(@Path('token') String? token,
      {@Path('headers') String? headers});
}
