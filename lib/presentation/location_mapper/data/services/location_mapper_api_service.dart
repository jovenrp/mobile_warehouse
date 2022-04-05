import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'location_mapper_api_service.g.dart';

@RestApi(baseUrl: 'http://166.70.31.151:5000')
abstract class LocationMapperApiService {
  factory LocationMapperApiService(Dio dio, {String baseUrl}) =
      _LocationMapperApiService;
}
