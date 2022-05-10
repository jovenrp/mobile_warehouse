import 'package:mobile_warehouse/presentation/stock_count/data/models/stock_count_item_model.dart';
import 'package:mobile_warehouse/presentation/stock_count/data/models/stock_count_response.dart';
import 'package:mobile_warehouse/presentation/stock_count/data/services/stock_counts_api_service.dart';
import 'package:mobile_warehouse/presentation/stock_count/domain/repositories/stock_count_repository.dart';

class StockCountRepositoryImpl implements StockCountRepository {
  StockCountRepositoryImpl(this._apiService);

  final StockCountApiService _apiService;

  @override
  Future<StockCountResponse> fetchStockCounts(
      {String? token, String? pickTicketId}) async {
    StockCountItemModel itemModel1 = StockCountItemModel(
        id: '1',
        sku: '100001',
        name: 'Ichigo Kurusaki',
        description: 'Lorem ipsum technology sanyo');
    StockCountItemModel itemModel2 = StockCountItemModel(
        id: '1',
        sku: '100002',
        name: 'Son Goku',
        description: 'Lorem ipsum technology sanyo');
    StockCountItemModel itemModel3 = StockCountItemModel(
        id: '1',
        sku: '100003',
        name: 'Monkey D. Luffy',
        description: 'Lorem ipsum technology sanyo');
    StockCountResponse response = StockCountResponse(
        error: false,
        message: 'success',
        stockCounts: <StockCountItemModel>[itemModel1, itemModel2, itemModel3]);
    return response;
  }
}
