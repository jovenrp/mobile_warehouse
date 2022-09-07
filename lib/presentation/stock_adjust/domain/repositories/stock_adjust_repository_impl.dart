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
      {String? token,
      String? containerId,
      String? sku,
      String? qty,
      bool? absolute}) async {
    try {
      final String result = await _apiService.stockAdjust(token,
          data: '|keys:containerId=$containerId^sku=$sku|vals:qty=$qty');

      final StockAdjustResponse response =
          StockAdjustResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return StockAdjustResponse(
          error: true, message: 'Stock adjust has an api error.');
    }
  }

  @override
  Future<StockAdjustResponse> stockLookUp(
      {String? token, String? sku, String? locNum}) async {
    try {
      final String result = await _apiService.stockLookup(token,
          data: '|keys:sku=$sku^locNum=$locNum');

      final StockAdjustResponse response =
          StockAdjustResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return StockAdjustResponse(
          error: true, message: 'Stock look up has an api error.');
    }
  }
}
