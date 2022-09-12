import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_model.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_response.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/data/models/ship_tickets_model.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/data/models/ship_tickets_response.dart';

part 'ship_tickets_state.freezed.dart';

@freezed
class ShipTicketsState with _$ShipTicketsState {
  factory ShipTicketsState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      ShipTicketsResponse? response,
      List<ShipTicketsModel>? shipTicketsModel,
      String? errorMessage,
      @Default(false) bool didFinish,
      String? token}) = _ShipTicketsState;
}
