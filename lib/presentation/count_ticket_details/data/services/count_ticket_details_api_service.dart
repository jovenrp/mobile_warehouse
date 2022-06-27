import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'count_ticket_details_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class CountTicketDetailsApiService {
  factory CountTicketDetailsApiService(Dio dio, {String baseUrl}) =
      _CountTicketDetailsApiService;

  @POST(
      '/mobile(getCountTicketDetailSummary)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> getCountTicketDetailSummary(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});
}
