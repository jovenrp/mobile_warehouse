import 'package:json_annotation/json_annotation.dart';

part 'stock_adjust_model.g.dart';

@JsonSerializable()
class StockAdjustModel {
  const StockAdjustModel({
    this.qty,
    this.id,
  });

  factory StockAdjustModel.fromJson(Map<String, dynamic> json) =>
      _$StockAdjustModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockAdjustModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'qty')
  final String? qty;
}
