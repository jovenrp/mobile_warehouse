import 'package:json_annotation/json_annotation.dart';

import 'container_model.dart';

part 'parent_location_model.g.dart';

@JsonSerializable()
class ParentLocationModel {
  ParentLocationModel({this.error, this.message, this.container});

  factory ParentLocationModel.fromJson(Map<String, dynamic> json) =>
      _$ParentLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParentLocationModelToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'container')
  final List<ContainerModel>? container;

  void setMessage(String value) {
    message = value;
  }
}
