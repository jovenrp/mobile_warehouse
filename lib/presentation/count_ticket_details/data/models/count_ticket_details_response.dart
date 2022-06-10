import 'package:json_annotation/json_annotation.dart';

import 'count_ticket_details_model.dart';

part 'count_ticket_details_response.g.dart';

@JsonSerializable()
class CountTicketDetailsReponse {
  const CountTicketDetailsReponse({
    this.error,
    this.message,
    this.countTicketDetails,
  });

  factory CountTicketDetailsReponse.fromJson(Map<String, dynamic> json) =>
      _$CountTicketDetailsReponseFromJson(json);
  Map<String, dynamic> toJson() => _$CountTicketDetailsReponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'countTicketDetails')
  final List<CountTicketDetailsModel>? countTicketDetails;
}
