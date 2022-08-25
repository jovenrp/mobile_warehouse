import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'container_move_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class ContainerMoveApiService {
  factory ContainerMoveApiService(Dio dio, {String baseUrl}) =
      _ContainerMoveApiService;

  @POST(
      '/mobile(moveContainer)?useHdrs=true&sessId={token}&containerId={containerId}&destContainerId={destContainerId}')
  Future<dynamic> moveContainer(@Path('token') String? token,
      {@Path('headers') String? headers,
      @Path('containerId') String? containerId,
      @Path('destContainerId') String? destContainerId});

  @POST('/mobile(getContainers)?useHdrs=true&sessId={token}')
  Future<dynamic> getContainers(@Path('token') String? token,
      {@Path('headers') String? headers});
}
