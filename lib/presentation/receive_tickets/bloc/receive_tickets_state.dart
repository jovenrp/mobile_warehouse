import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_model.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_response.dart';

part 'receive_tickets_state.freezed.dart';

@freezed
class ReceiveTicketsState with _$ReceiveTicketsState {
  factory ReceiveTicketsState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      ReceiveTicketsResponse? response,
      List<ReceiveTicketsModel>? receiveTicketsModel,
      String? errorMessage,
      @Default(false) bool didFinish,
      String? token}) = _ReceiveTicketsState;
}
