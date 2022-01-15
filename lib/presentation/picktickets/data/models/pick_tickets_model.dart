import 'package:json_annotation/json_annotation.dart';

part 'pick_tickets_model.g.dart';

@JsonSerializable()
class PickTicketsModel {
  const PickTicketsModel({
    this.status,
    this.ticketId,
    this.location,
    this.lines,
    this.sku,
  });

  factory PickTicketsModel.fromJson(Map<String, dynamic> json) =>
      _$PickTicketsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PickTicketsModelToJson(this);

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'ticketId')
  final String? ticketId;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'lines')
  final String? lines;

  @JsonKey(name: 'sku')
  final String? sku;
}
