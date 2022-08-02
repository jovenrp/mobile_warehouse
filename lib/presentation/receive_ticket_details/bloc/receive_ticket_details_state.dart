import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_model.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_response.dart';

part 'receive_ticket_details_state.freezed.dart';

@freezed
class ReceiveTicketDetailsState with _$ReceiveTicketDetailsState {
  factory ReceiveTicketDetailsState(
      {@Default(false) bool isLoading,
      @Default(false) bool isUpdateLoading,
      @Default(false) bool isCompleteTicket,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      ReceiveTicketDetailsResponse? response,
      List<ReceiveTicketDetailsModel>? receiveTicketDetailsModel,
      String? errorMessage,
      bool? isOverPicked,
      String? dummyPickTicketId,
      String? dummyQuantityPicked,
      ReceiveTicketDetailsModel? dummyReceiveTicketDetailsModel,
      @Default(false) bool didFinish,
      String? token}) = _ReceiveTicketDetailsState;
}
