import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'receive_ticket_details_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class ReceiveTicketDetailsApiService {
  factory ReceiveTicketDetailsApiService(Dio dio, {String baseUrl}) =
      _ReceiveTicketDetailsApiService;

  @POST('/mobile(getReceiveTicket)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> getReceiveTicket(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(beginReceiveDetail)?useHdrs=true&sessId={sessId}&data={data}')
  Future<dynamic> beginReceiveDetail(
      {@Path('headers') String? headers,
      @Path('sessId') String? sessId,
      @Path('data') String? data});
}
