import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_item_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/ticket_details_response_model.dart';

part 'pick_ticket_details_state.freezed.dart';

@freezed
class PickTicketDetailsState with _$PickTicketDetailsState {
  factory PickTicketDetailsState(
      {@Default(false) bool isLoading,
      @Default(false) bool isUpdateLoading,
      @Default(false) bool isCompleteTicket,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      @Default(false) bool didFinish,
      List<PickTicketDetailsModel>? pickTicketsResponse,
      List<PickTicketsItemModel>? pickTicketResponse,
      TicketDetailsResponseModel? ticketDetailsResponseModel,
      bool? pickLimitSetting,
      bool? isOverPicked,
      String? dummyPickTicketId,
      String? dummyQuantityPicked,
      PickTicketDetailsModel? dummyPickTicketDetailsModel,
      String? token}) = _PickTicketDetailsState;
}
