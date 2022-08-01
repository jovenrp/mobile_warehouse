import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'receive_tickets_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class ReceiveTicketsApiService {
  factory ReceiveTicketsApiService(Dio dio, {String baseUrl}) =
      _ReceiveTicketsApiService;

  @POST('/mobile(getReceiveTickets)?useHdrs=true&sessId={token}')
  Future<dynamic> getReceiveTickets(@Path('token') String? token,
      {@Path('headers') String? headers});
}
