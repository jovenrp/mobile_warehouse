import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'pick_ticket_details_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class PickTicketDetailsApiService {
  factory PickTicketDetailsApiService(Dio dio, {String baseUrl}) =
      _PickTicketDetailsApiService;

  @POST('/mobile(getPickTicket)?useHdrs=true&sessId={token}&id={pickTicketId}')
  Future<dynamic> fetchPickTicketsDetails(
      @Path('token') String? token, @Path('pickTicketId') String? pickTicketId,
      {@Path('headers') String? headers});

  @POST(
      '/mobile(getPickTickets)?useHdrs=true&sessId={token}&pickTicketDetailId={pickTicketDetailId}')
  Future<dynamic> beginPick(
      {@Path('headers') String? headers,
      @Path('token') String? token,
      @Path('pickTicketDetailId') String? pickTicketDetailId});

  @POST(
      '/mobile(getPickTickets)?useHdrs=true&sessId={token}&pickTicketDetailId={pickTicketDetailId}&qtyPicked={qtyPicked}')
  Future<dynamic> submitPick({
    @Path('headers') String? headers,
    @Path('token') String? token,
    @Path('pickTicketDetailId') String? pickTicketDetailId,
    @Path('qtyPicked') String? qtyPicked,
  });

  @POST(
      '/mobile(getPickTickets)?useHdrs=true&sessId={token}&pickTicketDetailId={pickTicketDetailId}')
  Future<dynamic> exitPick(
      {@Path('headers') String? headers,
      @Path('token') String? token,
      @Path('pickTicketDetailId') String? pickTicketDetailId});

  @POST(
      '/mobile(getPickTickets)?useHdrs=true&sessId={token}&pickTicket={pickTicket}')
  Future<dynamic> completePickTicket(
      {@Path('headers') String? headers,
      @Path('token') String? token,
      @Path('pickTicket') String? pickTicket});

  @POST(
      '/mobile(getPickTickets)?useHdrs=true&sessId={token}&pickTicket={pickTicket}')
  Future<dynamic> exitPickTicket(
      {@Path('headers') String? headers,
      @Path('token') String? token,
      @Path('pickTicket') String? pickTicket});
}
