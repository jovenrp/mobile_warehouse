import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_lookup_response.dart';

abstract class ItemLookupRepository {
  Future<ItemLookupResponse> lookupBarcodeStock(
      {String? token, String? item, String? param});

  Future<ItemLookupResponse> lookupItemAlias(
      {String? token, String? item, String? param});

  Future<ItemLookupResponse> getItemTrakList(
      {String? token, String? item, String? param});
}
