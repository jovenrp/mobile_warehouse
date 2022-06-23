import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_model.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/data/models/count_ticket_detail_model.dart';

part 'count_ticket_skus_state.freezed.dart';

@freezed
class CountTicketSkusState with _$CountTicketSkusState {
  factory CountTicketSkusState({
    @Default(false) bool isLoading,
    @Default(false) bool isSkuLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    CountTicketDetailsReponse? response,
    List<CountTicketDetailModel>? countTicketDetailModel,
    @Default(false) bool didFinish,
  }) = _CountTicketSkusState;
}
