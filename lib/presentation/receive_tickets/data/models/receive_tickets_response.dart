import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_model.dart';

part 'receive_tickets_response.g.dart';

@JsonSerializable()
class ReceiveTicketsResponse {
  const ReceiveTicketsResponse({
    this.error,
    this.message,
    this.receiveTicketsModel,
  });

  factory ReceiveTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReceiveTicketsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiveTicketsResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'getReceiveTickets')
  final List<ReceiveTicketsModel>? receiveTicketsModel;
}
