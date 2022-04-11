import 'package:mobile_warehouse/presentation/parent_location/data/models/parent_location_model.dart';

abstract class LocationMapperRepository {
  Future<String> getDropDown();

  Future<ParentLocationModel> getContainerChildren(
      String? token, String? parentId);
  Future<ParentLocationModel> getContainerParent(
      String? token, String? parentId);
}
