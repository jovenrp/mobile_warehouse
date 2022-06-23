import 'package:json_annotation/json_annotation.dart';

part 'count_ticket_detail_summary_model.g.dart';

@JsonSerializable()
class CountTicketDetailSummaryModel {
  const CountTicketDetailSummaryModel(
      {this.id, this.containerId, this.countedBy, this.numSkus, this.status});

  factory CountTicketDetailSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$CountTicketDetailSummaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountTicketDetailSummaryModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'containerId')
  final String? containerId;

  @JsonKey(name: 'countedBy')
  final String? countedBy;

  @JsonKey(name: 'numSkus')
  final String? numSkus;

  @JsonKey(name: 'status')
  final String? status;
}
