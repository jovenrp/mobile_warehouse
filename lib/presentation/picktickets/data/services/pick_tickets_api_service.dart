import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'pick_tickets_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class PickTicketsApiService {
  factory PickTicketsApiService(Dio dio, {String baseUrl}) =
      _PickTicketsApiService;

  @POST('/mobile(getPickTickets)?useHdrs=true&sessId={token}')
  Future<dynamic> fetchPickTickets(@Path('token') String? token,
      {@Path('headers') String? headers});

  @POST('/mobile(getPickTicket)?useHdrs=true&sessId={token}&id={pickTicketId}')
  Future<dynamic> fetchPickTicketsDetails(
      @Path('token') String? token, @Path('pickTicketId') String? pickTicketId,
      {@Path('headers') String? headers});
}
