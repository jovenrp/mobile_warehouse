import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_detail_summary_model.dart';

part 'count_ticket_details_state.freezed.dart';

@freezed
class CountTicketDetailsState with _$CountTicketDetailsState {
  factory CountTicketDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    CountTicketDetailsReponse? response,
    List<CountTicketDetailSummaryModel>? countTicketDetailSummaryModel,
    @Default(false) bool didFinish,
  }) = _CountTicketDetailsState;
}
