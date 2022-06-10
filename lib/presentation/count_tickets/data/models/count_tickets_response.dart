import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/count_tickets/data/models/count_tickets_model.dart';

part 'count_tickets_response.g.dart';

@JsonSerializable()
class CountTicketsReponse {
  const CountTicketsReponse({
    this.error,
    this.message,
    this.countTickets,
  });

  factory CountTicketsReponse.fromJson(Map<String, dynamic> json) =>
      _$CountTicketsReponseFromJson(json);
  Map<String, dynamic> toJson() => _$CountTicketsReponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'countTickets')
  final List<CountTicketsModel>? countTickets;
}
