import 'package:json_annotation/json_annotation.dart';
import 'container_model.dart';

part 'container_response.g.dart';

@JsonSerializable()
class ContainerResponse {
  const ContainerResponse({
    this.error,
    this.message,
    this.getContainers,
  });

  factory ContainerResponse.fromJson(Map<String, dynamic> json) =>
      _$ContainerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContainerResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'getContainers')
  final List<ContainerModel>? getContainers;
}
