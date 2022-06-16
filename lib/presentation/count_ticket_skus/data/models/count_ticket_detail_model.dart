import 'package:json_annotation/json_annotation.dart';

part 'count_ticket_detail_model.g.dart';

@JsonSerializable()
class CountTicketDetailModel {
  const CountTicketDetailModel({
    this.id,
    this.itemId,
    this.itemNum,
    this.userId,
    this.fullName,
    this.pickedById,
    this.containerId,
    this.containerCode,
    this.sku,
    this.qty,
    this.uom,
    this.notes,
    this.status,
    this.destination,
  });

  factory CountTicketDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CountTicketDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountTicketDetailModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'itemId')
  final String? itemId;

  @JsonKey(name: 'itemNum')
  final String? itemNum;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'fullName')
  final String? fullName;

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

  @JsonKey(name: 'destination')
  final String? destination;

  @JsonKey(name: 'pickedById')
  final String? pickedById;
}
