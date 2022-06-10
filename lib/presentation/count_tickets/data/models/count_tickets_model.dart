import 'package:json_annotation/json_annotation.dart';

part 'count_tickets_model.g.dart';

@JsonSerializable()
class CountTicketsModel {
  const CountTicketsModel({
    this.id,
    this.status,
    this.num,
    this.containerId,
    this.type,
    this.comments,
    this.notes,
    this.isHold,
    this.createdById,
    this.createdBy,
  });

  factory CountTicketsModel.fromJson(Map<String, dynamic> json) =>
      _$CountTicketsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountTicketsModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'num')
  final String? num;

  @JsonKey(name: 'containerId')
  final String? containerId;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'comments')
  final String? comments;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'isHold')
  final String? isHold;

  @JsonKey(name: 'createdById')
  final String? createdById;

  @JsonKey(name: 'createdBy')
  final String? createdBy;
}
