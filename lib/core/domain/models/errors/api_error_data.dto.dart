import 'package:json_annotation/json_annotation.dart';

part 'api_error_data.dto.g.dart';

@JsonSerializable()
class ApiErrorDataDto {
  const ApiErrorDataDto({
    this.unlockDuration,
    this.timesWrongPin,
    this.timeRecovery,
    this.timesRemainInputPin,
    this.timeBlock,
    this.title,
    this.timesSendEmail,
    this.times,
    this.timesSentEmailVerification,
    this.maxQuantity,
    this.description,
    this.dawnToken,
  });

  factory ApiErrorDataDto.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorDataDtoToJson(this);

  @JsonKey(name: 'unlockDuration')
  final String? unlockDuration;

  @JsonKey(name: 'timesWrongPin')
  final String? timesWrongPin;

  @JsonKey(name: 'timeRecovery')
  final String? timeRecovery;

  @JsonKey(name: 'timesRemainInputPin')
  final String? timesRemainInputPin;

  @JsonKey(name: 'timeBlock')
  final String? timeBlock;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'timesSendEmail')
  final String? timesSendEmail;

  @JsonKey(name: 'times')
  final String? times;

  @JsonKey(name: 'timesSentEmailVerification')
  final int? timesSentEmailVerification;

  @JsonKey(name: 'maxQuantity')
  final int? maxQuantity;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'dwn_token')
  final String? dawnToken;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiErrorDataDto &&
        other.unlockDuration == unlockDuration &&
        other.timesWrongPin == timesWrongPin &&
        other.timeRecovery == timeRecovery &&
        other.timesRemainInputPin == timesRemainInputPin &&
        other.timeBlock == timeBlock &&
        other.title == title &&
        other.timesSendEmail == timesSendEmail &&
        other.times == times &&
        other.timesSentEmailVerification == timesSentEmailVerification &&
        other.maxQuantity == maxQuantity &&
        other.description == description &&
        other.dawnToken == dawnToken;
  }

  @override
  int get hashCode {
    return unlockDuration.hashCode ^
        timesWrongPin.hashCode ^
        timeRecovery.hashCode ^
        timesRemainInputPin.hashCode ^
        timeBlock.hashCode ^
        title.hashCode ^
        timesSendEmail.hashCode ^
        times.hashCode ^
        timesSentEmailVerification.hashCode ^
        maxQuantity.hashCode ^
        description.hashCode ^
        dawnToken.hashCode;
  }
}
