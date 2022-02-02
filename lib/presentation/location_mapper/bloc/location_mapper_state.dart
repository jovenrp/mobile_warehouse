import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';

part 'location_mapper_state.freezed.dart';

@freezed
class LocationMapperState with _$LocationMapperState {
  factory LocationMapperState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      @Default(false) bool didFinish,
      String? token}) = _LocationMapperState;
}
