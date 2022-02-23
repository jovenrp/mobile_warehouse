import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/ticket_details_response_model.dart';

part 'ticket_details_response.g.dart';

@JsonSerializable()
class TicketDetailsResponse {
  const TicketDetailsResponse({
    this.result,
  });

  factory TicketDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TicketDetailsResponseToJson(this);

  @JsonKey(name: 'result')
  final TicketDetailsResponseModel? result;
}
