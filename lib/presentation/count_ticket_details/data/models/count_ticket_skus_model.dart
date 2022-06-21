import 'package:json_annotation/json_annotation.dart';

part 'count_ticket_skus_model.g.dart';

@JsonSerializable()
class CountTicketSkusModel {
  const CountTicketSkusModel(
      {this.id, this.containerId, this.countedBy, this.numSkus});

  factory CountTicketSkusModel.fromJson(Map<String, dynamic> json) =>
      _$CountTicketSkusModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountTicketSkusModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'containerId')
  final String? containerId;

  @JsonKey(name: 'countedBy')
  final String? countedBy;

  @JsonKey(name: 'numSkus')
  final String? numSkus;
}
