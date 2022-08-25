import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';

part 'container_move_state.freezed.dart';

@freezed
class ContainerMoveState with _$ContainerMoveState {
  factory ContainerMoveState(
      {@Default(false) bool isLoading,
      @Default(false) bool isLoadingDestination,
      @Default(false) bool isMovingSuccess,
      @Default(false) bool isInit,
      @Default(false) bool isDestInit,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      ContainerResponse? response,
      List<ContainerModel>? containers,
      List<ContainerModel>? containersDestination,
      ContainerModel? container,
      @Default(false) bool didFinish,
      String? token}) = _ContainerMoveState;
}
