import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';

part 'pick_ticket_details_state.freezed.dart';

@freezed
class PickTicketDetailsState with _$PickTicketDetailsState {
  factory PickTicketDetailsState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      @Default(false) bool didFinish,
      PickTicketsDetailsResponse? pickTicketsDetailsResponse,
      String? token}) = _PickTicketDetailsState;
}
