import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/presentation/container_move/data/services/container_move_api_service.dart';
import 'container_move_repository.dart';

class ContainerMoveRepositoryImpl implements ContainerMoveRepository {
  ContainerMoveRepositoryImpl(this._apiService);

  final ContainerMoveApiService _apiService;

  @override
  Future<String> moveContainer(
      {String? token, String? containerId, String? destContainerId}) async {
    try {
      final String result = await _apiService.moveContainer(
        token,
        containerId: containerId,
        destContainerId: destContainerId,
      );

      /*final StockAdjustResponse response =
      StockAdjustResponse.fromJson(jsonDecode(result));*/

      return '';
    } catch (_) {
      logger.e(_.toString());
      return '';
      /*return StockAdjustResponse(
          error: true, message: 'Stock adjust has an api error.');*/
    }
  }

  @override
  Future<List<ContainerModel>?> searchContainer(
      {String? token, String? containerNum}) async {
    try {
      print('WHATTHE?? $containerNum');
      final String result = await _apiService.getContainers(
        token,
      );

      final ContainerResponse response =
          ContainerResponse.fromJson(jsonDecode(result));

      return response.getContainers;
    } catch (_) {
      logger.e(_.toString());
      return <ContainerModel>[];
    }
  }
}
