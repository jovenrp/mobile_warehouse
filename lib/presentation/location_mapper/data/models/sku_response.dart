import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/location_mapper/data/models/sku_model.dart';

part 'sku_response.g.dart';

@JsonSerializable()
class SkuResponse {
  const SkuResponse({this.error, this.message, this.skus});

  factory SkuResponse.fromJson(Map<String, dynamic> json) =>
      _$SkuResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SkuResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'skus')
  final List<SkuModel>? skus;
}
