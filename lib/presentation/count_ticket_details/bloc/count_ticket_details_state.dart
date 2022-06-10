import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_model.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';

part 'count_ticket_details_state.freezed.dart';

@freezed
class CountTicketDetailsState with _$CountTicketDetailsState {
  factory CountTicketDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    CountTicketDetailsReponse? response,
    List<CountTicketDetailsModel>? countTicketDetailsModel,
    @Default(false) bool didFinish,
  }) = _CountTicketDetailsState;
}
