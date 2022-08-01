import 'package:json_annotation/json_annotation.dart';

part 'receive_tickets_model.g.dart';

@JsonSerializable()
class ReceiveTicketsModel {
  const ReceiveTicketsModel({
    this.id,
    this.userId,
    this.fullName,
    this.num,
    this.type,
    this.numLines,
    this.status,
    this.poId,
    this.vendorId,
    this.vendorName,
  });

  factory ReceiveTicketsModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiveTicketsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiveTicketsModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'fullName')
  final String? fullName;

  @JsonKey(name: 'num')
  final String? num;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'numLines')
  final String? numLines;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'poId')
  final String? poId;

  @JsonKey(name: 'vendorId')
  final String? vendorId;

  @JsonKey(name: 'vendorName')
  final String? vendorName;
}
