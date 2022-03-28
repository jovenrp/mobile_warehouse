import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'pick_ticket_details_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class PickTicketDetailsApiService {
  factory PickTicketDetailsApiService(Dio dio, {String baseUrl}) =
      _PickTicketDetailsApiService;

  @POST(
      '/mobile(getPickTicket)?useHdrs=true&sessId={token}&data={pickTicketId}')
  Future<dynamic> fetchPickTicketsDetails(
      @Path('token') String? token, @Path('pickTicketId') String? pickTicketId,
      {@Path('headers') String? headers});

  @POST(
      '/mobile(beginPick)?useHdrs=true&sessId={sessId}&data={pickTicketDetailId}')
  Future<dynamic> beginPick(
      {@Path('headers') String? headers,
      @Path('sessId') String? sessId,
      @Path('pickTicketDetailId') String? pickTicketDetailId});

  @POST(
      '/mobile(submitPick)?useHdrs=true&sessId={sessId}&data={pickTicketDetailId}')
  Future<dynamic> submitPick({
    @Path('headers') String? headers,
    @Path('sessId') String? sessId,
    @Path('pickTicketDetailId') String? pickTicketDetailId,
    @Path('qtyPicked') String? qtyPicked,
  });

  @POST(
      '/mobile(exitPick)?useHdrs=true&sessId={sessId}&data={pickTicketDetailId}')
  Future<dynamic> exitPick(
      {@Path('headers') String? headers,
      @Path('sessId') String? sessId,
      @Path('pickTicketDetailId') String? pickTicketDetailId});

  @POST(
      '/mobile(completePickTicket)?useHdrs=true&sessId={sessId}&data={pickTicketId}')
  Future<dynamic> completePickTicket(
      {@Path('headers') String? headers,
      @Path('sessId') String? sessId,
      @Path('pickTicketId') String? pickTicketId});

  @POST(
      '/mobile(exitPickTicket)?useHdrs=true&sessId={sessId}&pickTicket={pickTicket}')
  Future<dynamic> exitPickTicket(
      {@Path('headers') String? headers,
      @Path('sessId') String? sessId,
      @Path('pickTicket') String? pickTicket});
}
