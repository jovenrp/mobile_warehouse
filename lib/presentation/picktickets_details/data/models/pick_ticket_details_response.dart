import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_item_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';

part 'pick_ticket_details_response.g.dart';

@JsonSerializable()
class PickTicketsDetailsResponse {
  const PickTicketsDetailsResponse({
    this.error,
    this.message,
    this.pickTicketsResponse,
    this.pickTicketResponse,
  });

  factory PickTicketsDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PickTicketsDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PickTicketsDetailsResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'pickTicketDetails')
  final List<PickTicketDetailsModel>? pickTicketsResponse;

  @JsonKey(name: 'pickTicket')
  final List<PickTicketsItemModel>? pickTicketResponse;
}
