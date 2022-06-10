import 'package:json_annotation/json_annotation.dart';

part 'count_ticket_details_model.g.dart';

@JsonSerializable()
class CountTicketDetailsModel {
  const CountTicketDetailsModel({
    this.id,
    this.itemId,
    this.itemNum,
    this.userId,
    this.countedBy,
    this.containerId,
    this.containerCode,
    this.sku,
    this.qty,
    this.uom,
    this.notes,
    this.status,
  });

  factory CountTicketDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CountTicketDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountTicketDetailsModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'itemId')
  final String? itemId;

  @JsonKey(name: 'itemNum')
  final String? itemNum;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'countedBy')
  final String? countedBy;

  @JsonKey(name: 'containerId')
  final String? containerId;

  @JsonKey(name: 'containerCode')
  final String? containerCode;

  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'qty')
  final String? qty;

  @JsonKey(name: 'uom')
  final String? uom;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'status')
  final String? status;
}
