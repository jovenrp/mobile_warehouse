import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/models/stock_yield_response.dart';

abstract class StockMoveRepository {
  Future<StockYieldResponse> stockMove(
      {String? token,
      String? sourceStockId,
      String? destContainerId,
      String? sku,
      String? qty});

  Future<ContainerResponse> searchContainer(
      {String? token, String? containerNum});
}
