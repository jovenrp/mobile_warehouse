import 'package:json_annotation/json_annotation.dart';

part 'stock_item_model.g.dart';

@JsonSerializable()
class StockItemModel {
  const StockItemModel({
    this.id,
    this.containerId,
    this.itemId,
    this.itemNum,
    this.sku,
    this.uom,
    this.name,
    this.qty,
    this.stockType,
  });

  factory StockItemModel.fromJson(Map<String, dynamic> json) =>
      _$StockItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockItemModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'containerId')
  final String? containerId;

  @JsonKey(name: 'itemId')
  final String? itemId;

  @JsonKey(name: 'itemNum')
  final String? itemNum;

  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'uom')
  final String? uom;

  @JsonKey(name: 'qty')
  final String? qty;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'stockType')
  final String? stockType;
}
