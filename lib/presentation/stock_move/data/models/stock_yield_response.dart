import 'package:json_annotation/json_annotation.dart';

part 'stock_yield_response.g.dart';

@JsonSerializable()
class StockYieldResponse {
  const StockYieldResponse({
    this.error,
    this.message,
  });

  factory StockYieldResponse.fromJson(Map<String, dynamic> json) =>
      _$StockYieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StockYieldResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;
}
