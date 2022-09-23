import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'pack_tickets_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class PackTicketsApiService {
  factory PackTicketsApiService(Dio dio, {String baseUrl}) =
      _PackTicketsApiService;

  @POST('/mobile(getPackTickets)?useHdrs=true&sessId={token}')
  Future<dynamic> getPackTickets(@Path('token') String? token,
      {@Path('headers') String? headers});
}
