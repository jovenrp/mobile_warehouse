import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/stock_count/data/models/stock_count_item_model.dart';

part 'stock_count_response.g.dart';

@JsonSerializable()
class StockCountResponse {
  StockCountResponse({this.error, this.message, this.stockCounts});

  factory StockCountResponse.fromJson(Map<String, dynamic> json) =>
      _$StockCountResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StockCountResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'stockcounts')
  final List<StockCountItemModel>? stockCounts;
}
