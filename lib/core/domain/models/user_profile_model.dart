import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  const UserProfileModel({
    required this.username,
    this.firstname,
    this.middlename,
    this.lastname,
    this.nickname,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  static UserProfileModel? fromJsonX(Map<String, dynamic>? json) =>
      json == null ? null : UserProfileModel.fromJson(json);

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'firstname')
  final String? firstname;

  @JsonKey(name: 'middlename')
  final String? middlename;

  @JsonKey(name: 'lastname')
  final String? lastname;

  @JsonKey(name: 'nickname')
  final String? nickname;
}
