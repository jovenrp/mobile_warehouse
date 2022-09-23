import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/models/stock_yield_response.dart';

abstract class ContainerMoveRepository {
  Future<StockYieldResponse> moveContainer(
      {String? token, String? containerId, String? destContainerId});

  Future<ContainerResponse> searchContainer(
      {String? token, String? containerNum});
}
