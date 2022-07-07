import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'count_ticket_skus_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class CountTicketSkusApiService {
  factory CountTicketSkusApiService(Dio dio, {String baseUrl}) =
      _CountTicketSkusApiService;

  @POST(
      '/mobile(getCountTicketDetailSkus)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> getCountTicketDetailSkus(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST(
      '/mobile(getCountTicketDetailStock)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> getCountTicketDetailStock(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(beginCount)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> beginCount(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});

  @POST('/mobile(exitCount)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> exitCount(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});
}
