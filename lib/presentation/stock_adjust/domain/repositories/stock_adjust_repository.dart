import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_response.dart';

abstract class StockAdjustRepository {
  Future<StockAdjustResponse> stockAdjust(
      {String? token, String? stockId, String? qty, bool? absolute});
}
