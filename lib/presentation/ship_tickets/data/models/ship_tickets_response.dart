import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/data/models/ship_tickets_model.dart';

part 'ship_tickets_response.g.dart';

@JsonSerializable()
class ShipTicketsResponse {
  const ShipTicketsResponse({
    this.error,
    this.message,
    this.shipTicketsModel,
  });

  factory ShipTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$ShipTicketsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShipTicketsResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'shipTicketsModel')
  final List<ShipTicketsModel>? shipTicketsModel;
}
