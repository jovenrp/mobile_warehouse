import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_model.dart';

part 'pick_tickets_state.freezed.dart';

@freezed
class PickTicketsState with _$PickTicketsState {
  factory PickTicketsState(
      {@Default(false) bool isLoading,
      @Default(<PickTicketsModel>[]) List<PickTicketsModel>? pickTicketsModel,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      @Default(false) bool didFinish,
      String? token}) = _PickTicketsState;
}
