import 'package:json_annotation/json_annotation.dart';

part 'pick_tickets_item_model.g.dart';

@JsonSerializable()
class PickTicketsItemModel {
  const PickTicketsItemModel({
    this.status,
    this.id,
    this.location,
    this.lines,
    this.num,
  });

  factory PickTicketsItemModel.fromJson(Map<String, dynamic> json) =>
      _$PickTicketsItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$PickTicketsItemModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'num')
  final String? num;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'lines')
  final String? lines;
}