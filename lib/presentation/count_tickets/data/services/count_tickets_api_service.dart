import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'count_tickets_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class CountTicketsApiService {
  factory CountTicketsApiService(Dio dio, {String baseUrl}) =
      _CountTicketsApiService;

  @POST('/mobile(getCountTickets)?useHdrs=true&sessId={token}')
  Future<dynamic> getCountTickets(@Path('token') String? token,
      {@Path('headers') String? headers});
}
