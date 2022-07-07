import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_detail_summary_model.dart';

part 'count_ticket_details_response.g.dart';

@JsonSerializable()
class CountTicketDetailsReponse {
  const CountTicketDetailsReponse({
    this.error,
    this.message,
    this.countTicketDetailSummary,
  });

  factory CountTicketDetailsReponse.fromJson(Map<String, dynamic> json) =>
      _$CountTicketDetailsReponseFromJson(json);
  Map<String, dynamic> toJson() => _$CountTicketDetailsReponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'countTicketDetailSummary')
  final List<CountTicketDetailSummaryModel>? countTicketDetailSummary;
}
