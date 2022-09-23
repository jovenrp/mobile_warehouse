import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/pack_tickets/data/models/pack_tickets_model.dart';
import 'package:mobile_warehouse/presentation/pack_tickets/data/models/pack_tickets_response.dart';

part 'pack_tickets_state.freezed.dart';

@freezed
class PackTicketsState with _$PackTicketsState {
  factory PackTicketsState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      PackTicketsResponse? response,
      List<PackTicketsModel>? packTicketsModel,
      String? errorMessage,
      @Default(false) bool didFinish,
      String? token}) = _PackTicketsState;
}
