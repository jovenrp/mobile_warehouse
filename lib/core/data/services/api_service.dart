import 'package:dio/dio.dart';
import 'package:mobile_warehouse/core/data/services/api_services/actiontrak_api_service.dart';

class ApiService {
  factory ApiService({required Dio dio}) =>
      ApiService._(ActionTRAKApiService(dio));

  ApiService._(
    this.actionTRAKApiService,
  );

  // * Services
  final ActionTRAKApiService actionTRAKApiService;

  // * |--------------------------------------------------------------
  // * |--------------------------------------------------------------
}
