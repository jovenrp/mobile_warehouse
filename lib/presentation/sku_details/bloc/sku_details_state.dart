import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';

import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';

part 'sku_details_state.freezed.dart';

@freezed
class SkuDetailsState with _$SkuDetailsState {
  factory SkuDetailsState(
      {@Default(false) bool isLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      @Default(false) bool didFinish,
      PickTicketDetailsModel? pickTicketDetailsModel,
      String? token}) = _SkuDetailsState;
}
