import 'package:dio/dio.dart' hide Headers;
import 'package:mobile_warehouse/core/domain/utils/interceptors/api_interceptor.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';
import 'package:retrofit/http.dart';

part 'pick_tickets_api_service.g.dart';

@RestApi(baseUrl: 'http://76.27.84.31:5555')
abstract class PickTicketsApiService {
  factory PickTicketsApiService(Dio dio, {String baseUrl}) =
      _PickTicketsApiService;

  @POST('/mobile(getPickTickets)?useHdrs=true&sessId={token}')
  Future<dynamic> fetchPickTickets(@Path('token') String? token,
      {@Path('headers') String? headers});

  @POST(
      '/mobile(getPickTicketDetails)?useHdrs=true&sessId={token}&pickTicketId={pickTicketId}')
  Future<dynamic> fetchPickTicketsDetails(
      @Path('token') String? token, @Path('pickTicketId') String? pickTicketId,
      {@Path('headers') String? headers});

  @POST('/mobile(getPickTicketDetails)')
  @Headers(<String, dynamic>{
    ApiInterceptor.includeDwnToken: 'true',
  })
  Future<dynamic> updateTicketDetails(
      {List<PickTicketDetailsModel>? pickTicketDetailsModel});
}
