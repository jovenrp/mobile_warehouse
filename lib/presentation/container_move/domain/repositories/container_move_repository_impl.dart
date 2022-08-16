import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/container_move/data/services/container_move_api_service.dart';
import 'container_move_repository.dart';

class ContainerMoveRepositoryImpl implements ContainerMoveRepository {
  ContainerMoveRepositoryImpl(this._apiService);

  final ContainerMoveApiService _apiService;

  @override
  Future<String> containerMove(
      {String? token, String? stockId, String? stockLocId}) async {
    try {
      /*final String result = await _apiService.stockMove(token,
          stockId: stockId);

      final StockAdjustResponse response =
      StockAdjustResponse.fromJson(jsonDecode(result));*/

      return '';
    } catch (_) {
      logger.e(_.toString());
      return '';
      /*return StockAdjustResponse(
          error: true, message: 'Stock adjust has an api error.');*/
    }
  }
}
