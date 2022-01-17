import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_response.dart';

part 'pick_tickets_state.freezed.dart';

@freezed
class PickTicketsState with _$PickTicketsState {
  factory PickTicketsState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      PickTicketsResponse? pickTicketsModel,
      String? errorMessage,
      @Default(false) bool didFinish,
      String? token}) = _PickTicketsState;
}
