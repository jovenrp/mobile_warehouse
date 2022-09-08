import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_response.dart';

abstract class StockMoveRepository {
  Future<String> stockMove(
      {String? token,
      String? sourceStockId,
      String? destContainerId,
      String? sku,
      String? qty});

  Future<List<ContainerModel>?> searchContainer(
      {String? token, String? containerNum});
}
