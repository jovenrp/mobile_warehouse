import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
part 'container_move_state.freezed.dart';

@freezed
class ContainerMoveState with _$ContainerMoveState {
  factory ContainerMoveState(
      {@Default(false) bool isLoading,
      @Default(false) bool isStockLoading,
      @Default(false) bool isAdjustLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      @Default(false) bool didFinish,
      String? token}) = _ContainerMoveState;
}
