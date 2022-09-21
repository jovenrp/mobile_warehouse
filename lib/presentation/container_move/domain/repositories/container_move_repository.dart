import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/models/stock_yield_response.dart';

abstract class ContainerMoveRepository {
  Future<StockYieldResponse> moveContainer(
      {String? token, String? containerId, String? destContainerId});

  Future<List<ContainerModel>?> searchContainer(
      {String? token, String? containerNum});
}
