import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  const LoginResponseModel({
    this.token,
    this.isError = false,
    this.errorMessage,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'isError')
  final bool isError;

  @JsonKey(name: 'errorMessage')
  final String? errorMessage;
}
