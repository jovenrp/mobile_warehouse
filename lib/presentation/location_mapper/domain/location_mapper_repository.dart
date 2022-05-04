import 'package:mobile_warehouse/presentation/location_mapper/data/models/sku_response.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/parent_location_model.dart';

abstract class LocationMapperRepository {
  Future<String> getDropDown();

  Future<ParentLocationModel> getContainerChildren(
      String? token, String? parentId);

  Future<ParentLocationModel> getContainerParent(
      String? token, String? parentId);

  Future<ParentLocationModel> createContainer(
      {String? token,
      String? parentId,
      String? name,
      String? code,
      String? num});

  Future<SkuResponse> getContainerSkus({String? token, String? parentId});
  Future<SkuResponse> removeSku({String? token, String? id, String? skuId});
  Future<SkuResponse> addSku({String? token, String? id, String? skuId});
  Future<ParentLocationModel> updateContainer(
      {String? token, String? id, String? code, String? serial});
}
