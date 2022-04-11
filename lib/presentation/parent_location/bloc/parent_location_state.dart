import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/container_model.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/parent_location_model.dart';

part 'parent_location_state.freezed.dart';

@freezed
class ParentLocationState with _$ParentLocationState {
  factory ParentLocationState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      ParentLocationModel? parentLocationModel,
      List<ContainerModel>? containerModel,
      @Default(false) bool didFinish,
      String? token}) = _ParentLocationState;
}
