import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/models/stock_yield_response.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/services/stock_move_api_service.dart';
import 'package:mobile_warehouse/presentation/stock_move/domain/repositories/stock_move_repository.dart';

class StockMoveRepositoryImpl implements StockMoveRepository {
  StockMoveRepositoryImpl(this._apiService);

  final StockMoveApiService _apiService;

  @override
  Future<StockYieldResponse> stockMove(
      {String? token,
      String? sourceStockId,
      String? destContainerId,
      String? sku,
      String? qty}) async {
    try {
      final String result = await _apiService.stockYieldBySku(token,
          data:
              '|keys:srcContainerId=$sourceStockId^sku=$sku|vals:docType=XO^docNum=TEST101^destContainerId=$destContainerId^qty=$qty');

      final StockYieldResponse response =
          StockYieldResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return StockYieldResponse(
          error: true, message: 'Stock yield has an api error.');
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
      return ContainerResponse(error: true, message: 'Search Container has an api error.');
    }
  }
}
