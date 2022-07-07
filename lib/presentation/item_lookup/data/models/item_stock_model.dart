import 'package:json_annotation/json_annotation.dart';

part 'item_stock_model.g.dart';

@JsonSerializable()
class ItemStockModel {
  const ItemStockModel({
    this.id,
    this.itemId,
    this.itemName,
    this.itemNum,
    this.stockType,
    this.qty,
    this.uom,
    this.lotNum,
    this.containerId,
    this.containerCode,
    this.containerName,
    this.containerNum,
  });

  factory ItemStockModel.fromJson(Map<String, dynamic> json) =>
      _$ItemStockModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemStockModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'itemId')
  final String? itemId;

  @JsonKey(name: 'itemNum')
  final String? itemNum;

  @JsonKey(name: 'itemName')
  final String? itemName;

  @JsonKey(name: 'stockType')
  final String? stockType;

  @JsonKey(name: 'qty')
  final String? qty;

  @JsonKey(name: 'uom')
  final String? uom;

  @JsonKey(name: 'lotNum')
  final String? lotNum;

  @JsonKey(name: 'containerId')
  final String? containerId;

  @JsonKey(name: 'containerCode')
  final String? containerCode;

  @JsonKey(name: 'containerNum')
  final String? containerNum;

  @JsonKey(name: 'containerName')
  final String? containerName;
}
