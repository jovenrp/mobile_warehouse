import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/models/stock_yield_response.dart';

part 'stock_move_state.freezed.dart';

@freezed
class StockMoveState with _$StockMoveState {
  factory StockMoveState(
      {@Default(false) bool isLoading,
      @Default(false) bool isLoadingDestination,
      @Default(false) bool isMovingSuccess,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      StockYieldResponse? response,
      List<ContainerModel>? containersDestination,
      List<ContainerModel>? containers,
      @Default(false) bool didFinish,
      String? token}) = _StockMoveState;
}
