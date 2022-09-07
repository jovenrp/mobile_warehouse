import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_response.dart';

abstract class StockAdjustRepository {
  Future<StockAdjustResponse> stockLookUp(
      {String? token, String? sku, String? locNum});

  Future<StockAdjustResponse> stockAdjust(
      {String? token,
      String? containerId,
      String? sku,
      String? qty,
      bool? absolute});
}
