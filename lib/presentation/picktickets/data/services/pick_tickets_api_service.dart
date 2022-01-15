import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'pick_tickets_api_service.g.dart';

@RestApi(baseUrl: 'http://76.27.84.31:5555')
abstract class PickTicketsApiService {
  factory PickTicketsApiService(Dio dio, {String baseUrl}) =
      _PickTicketsApiService;

  @POST('/mobile(getContainers)?useHdrs={headers}&authToken={token}')
  Future<String> getContainers(@Path('token') String? token);

  @POST('/mobile(getPickTickets)?authToken={token}&useHdrs=true')
  Future<String> fetchPickTickets(@Path('token') String? token,
      {@Path('headers') String? headers});
}
