import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/presentation/count_tickets/data/models/count_tickets_model.dart';
import 'package:mobile_warehouse/presentation/count_tickets/data/models/count_tickets_response.dart';

part 'count_tickets_state.freezed.dart';

@freezed
class CountTicketsState with _$CountTicketsState {
  factory CountTicketsState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    CountTicketsReponse? response,
    List<CountTicketsModel>? countTickets,
    @Default(false) bool didFinish,
  }) = _CountTicketsState;
}
