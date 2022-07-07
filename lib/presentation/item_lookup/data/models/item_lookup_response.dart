import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_stock_model.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_trak_model.dart';

import 'item_alias_model.dart';

part 'item_lookup_response.g.dart';

@JsonSerializable()
class ItemLookupResponse {
  const ItemLookupResponse({
    this.error,
    this.message,
    this.itemAlias,
    this.itemStock,
    this.itemTrak,
  });

  factory ItemLookupResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemLookupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ItemLookupResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'itemAlias')
  final List<ItemAliasModel>? itemAlias;

  @JsonKey(name: 'stock')
  final List<ItemStockModel>? itemStock;

  @JsonKey(name: 'trak')
  final List<ItemTrakModel>? itemTrak;
}
