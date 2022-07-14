import 'package:json_annotation/json_annotation.dart';

part 'item_alias_model.g.dart';

@JsonSerializable()
class ItemAliasModel {
  const ItemAliasModel({
    this.id,
    this.itemId,
    this.itemName,
    this.sku,
    this.itemNum,
    this.type,
    this.code,
    this.note,
    this.vendorId,
    this.vendorName,
  });

  factory ItemAliasModel.fromJson(Map<String, dynamic> json) =>
      _$ItemAliasModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAliasModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'itemId')
  final String? itemId;

  @JsonKey(name: 'itemNum')
  final String? itemNum;

  @JsonKey(name: 'itemName')
  final String? itemName;

  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'vendorId')
  final String? vendorId;

  @JsonKey(name: 'vendorName')
  final String? vendorName;
}
