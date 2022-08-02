import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_model.dart';

part 'receive_ticket_details_response.g.dart';

@JsonSerializable()
class ReceiveTicketDetailsResponse {
  const ReceiveTicketDetailsResponse({
    this.error,
    this.message,
    this.receiveTicketDetailsModel,
  });

  factory ReceiveTicketDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReceiveTicketDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiveTicketDetailsResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'rcvTicketDetails')
  final List<ReceiveTicketDetailsModel>? receiveTicketDetailsModel;
}
