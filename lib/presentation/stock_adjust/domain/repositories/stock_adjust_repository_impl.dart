import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_response.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/services/stock_adjust_api_service.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/domain/repositories/stock_adjust_repository.dart';

class StockAdjustRepositoryImpl implements StockAdjustRepository {
  StockAdjustRepositoryImpl(this._apiService);

  final StockAdjustApiService _apiService;

  @override
  Future<StockAdjustResponse> stockAdjust(
      {String? token, String? stockId, String? qty, bool? absolute}) async {
    try {
      final String result = await _apiService.stockAdjust(token,
          stockId: stockId, qty: qty, absolute: absolute);

      final StockAdjustResponse response =
          StockAdjustResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return StockAdjustResponse(
          error: true, message: 'Stock adjust has an api error.');
    }
  }
}
