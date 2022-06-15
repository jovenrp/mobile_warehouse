import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'count_ticket_skus_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class CountTicketSkusApiService {
  factory CountTicketSkusApiService(Dio dio, {String baseUrl}) =
      _CountTicketSkusApiService;

  @POST('/mobile(getCountTicketSkus)?useHdrs=true&sessId={token}&data={data}')
  Future<dynamic> getCountTicketSkus(@Path('token') String? token,
      {@Path('headers') String? headers, @Path('data') String? data});
}
