import 'package:json_annotation/json_annotation.dart';

part 'sku_model.g.dart';

@JsonSerializable()
class SkuModel {
  const SkuModel({this.id, this.sku, this.name});

  factory SkuModel.fromJson(Map<String, dynamic> json) =>
      _$SkuModelFromJson(json);
  Map<String, dynamic> toJson() => _$SkuModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'name')
  final String? name;
}
