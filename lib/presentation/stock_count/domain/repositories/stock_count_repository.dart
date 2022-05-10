import 'package:mobile_warehouse/presentation/stock_count/data/models/stock_count_response.dart';

abstract class StockCountRepository {
  Future<StockCountResponse> fetchStockCounts(
      {String? token, String? pickTicketId});
}
