import 'package:mobile_warehouse/core/domain/models/container_model.dart';

abstract class ContainerMoveRepository {
  Future<String> moveContainer(
      {String? token, String? containerId, String? destContainerId});

  Future<List<ContainerModel>?> searchContainer(
      {String? token, String? containerNum});
}
