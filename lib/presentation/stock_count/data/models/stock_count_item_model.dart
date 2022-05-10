import 'package:json_annotation/json_annotation.dart';

part 'stock_count_item_model.g.dart';

@JsonSerializable()
class StockCountItemModel {
  StockCountItemModel({this.id, this.sku, this.description, this.name});

  factory StockCountItemModel.fromJson(Map<String, dynamic> json) =>
      _$StockCountItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockCountItemModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'name')
  final String? name;
}
