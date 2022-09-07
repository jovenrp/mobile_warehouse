import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/services/stock_move_api_service.dart';
import 'package:mobile_warehouse/presentation/stock_move/domain/repositories/stock_move_repository.dart';

class StockMoveRepositoryImpl implements StockMoveRepository {
  StockMoveRepositoryImpl(this._apiService);

  final StockMoveApiService _apiService;

  @override
  Future<String> stockMove(
      {String? token,
      String? sourceStockId,
      String? destContainerId,
      String? qty}) async {
    try {
      final String result = await _apiService.stockYield(
        token,
        sourceStockId: sourceStockId,
        destContainerId: destContainerId,
        qty: qty,
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
