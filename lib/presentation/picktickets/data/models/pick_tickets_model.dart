import 'package:json_annotation/json_annotation.dart';

part 'pick_tickets_model.g.dart';

@JsonSerializable()
class PickTicketsModel {
  const PickTicketsModel({
    this.token,
  });

  factory PickTicketsModel.fromJson(Map<String, dynamic> json) =>
      _$PickTicketsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PickTicketsModelToJson(this);

  @JsonKey(name: 'token')
  final String? token;
}
