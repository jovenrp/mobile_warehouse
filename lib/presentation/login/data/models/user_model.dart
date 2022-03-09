import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    this.firstname,
    this.lastname,
    this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @JsonKey(name: 'firstname')
  final String? firstname;

  @JsonKey(name: 'lastname')
  final String? lastname;

  @JsonKey(name: 'username')
  final String? username;
}
