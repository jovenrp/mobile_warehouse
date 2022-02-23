import 'package:json_annotation/json_annotation.dart';

part 'ticket_details_response_model.g.dart';

@JsonSerializable()
class TicketDetailsResponseModel {
  const TicketDetailsResponseModel({
    this.error,
    this.message,
    this.status,
  });

  factory TicketDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TicketDetailsResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketDetailsResponseModelToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final String? status;
}
