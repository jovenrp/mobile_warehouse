import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/data/models/count_ticket_detail_model.dart';

import 'count_ticket_details_model.dart';

part 'count_ticket_details_response.g.dart';

@JsonSerializable()
class CountTicketDetailsReponse {
  const CountTicketDetailsReponse({
    this.error,
    this.message,
    this.countTicketDetails,
    this.countTicketDetail,
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

  @JsonKey(name: 'countTicketDetail')
  final List<CountTicketDetailModel>? countTicketDetail;
}
