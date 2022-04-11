import 'package:json_annotation/json_annotation.dart';

part 'container_model.g.dart';

@JsonSerializable()
class ContainerModel {
  const ContainerModel({this.id, this.parentId, this.num, this.code});

  factory ContainerModel.fromJson(Map<String, dynamic> json) =>
      _$ContainerModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContainerModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'parentId')
  final String? parentId;

  @JsonKey(name: 'num')
  final String? num;

  @JsonKey(name: 'code')
  final String? code;
}
