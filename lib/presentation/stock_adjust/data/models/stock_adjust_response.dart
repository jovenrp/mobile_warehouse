import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_item_model.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_model.dart';

part 'stock_adjust_response.g.dart';

@JsonSerializable()
class StockAdjustResponse {
  const StockAdjustResponse({
    this.error,
    this.message,
    this.stockAdjust,
  });

  factory StockAdjustResponse.fromJson(Map<String, dynamic> json) =>
      _$StockAdjustResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StockAdjustResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'stockAdjust')
  final List<StockAdjustModel>? stockAdjust;
}
