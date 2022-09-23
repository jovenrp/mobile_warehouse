import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/presentation/container_move/data/services/container_move_api_service.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/models/stock_yield_response.dart';
import 'container_move_repository.dart';

class ContainerMoveRepositoryImpl implements ContainerMoveRepository {
  ContainerMoveRepositoryImpl(this._apiService);

  final ContainerMoveApiService _apiService;

  @override
  Future<StockYieldResponse> moveContainer(
      {String? token, String? containerId, String? destContainerId}) async {
    try {
      final String result = await _apiService.moveContainer(
        token,
        containerId: containerId,
        destContainerId: destContainerId,
      );

      final StockYieldResponse response =
          StockYieldResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return StockYieldResponse(
          error: true, message: 'Container move has an api error.');
    }
  }

  @override
  Future<ContainerResponse> searchContainer(
      {String? token, String? containerNum}) async {
    try {
      final String result = await _apiService.getContainers(
        token,
      );

      final ContainerResponse response =
          ContainerResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ContainerResponse(error: true, message: 'Search container has an api error.');
    }
  }
}
