import 'package:json_annotation/json_annotation.dart';

part 'item_trak_model.g.dart';

@JsonSerializable()
class ItemTrakModel {
  const ItemTrakModel({
    this.id,
    this.itemId,
    this.itemName,
    this.itemNum,
    this.qtyMin,
    this.qtyAlert,
    this.qtyMax,
    this.qtyCap,
    this.qtyDemand,
    this.containerId,
    this.containerCode,
    this.containerName,
    this.containerNum,
  });

  factory ItemTrakModel.fromJson(Map<String, dynamic> json) =>
      _$ItemTrakModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemTrakModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'itemId')
  final String? itemId;

  @JsonKey(name: 'itemNum')
  final String? itemNum;

  @JsonKey(name: 'itemName')
  final String? itemName;

  @JsonKey(name: 'qtyMin')
  final String? qtyMin;

  @JsonKey(name: 'qtyAlert')
  final String? qtyAlert;

  @JsonKey(name: 'qtyMax')
  final String? qtyMax;

  @JsonKey(name: 'qtyCap')
  final String? qtyCap;

  @JsonKey(name: 'qtyDemand')
  final String? qtyDemand;

  @JsonKey(name: 'containerId')
  final String? containerId;

  @JsonKey(name: 'containerCode')
  final String? containerCode;

  @JsonKey(name: 'containerNum')
  final String? containerNum;

  @JsonKey(name: 'containerName')
  final String? containerName;
}
