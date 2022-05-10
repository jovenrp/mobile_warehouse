import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/core/domain/models/user_profile_model.dart';
import 'package:mobile_warehouse/presentation/stock_count/data/models/stock_count_item_model.dart';

part 'stock_count_state.freezed.dart';

@freezed
class StockCountState with _$StockCountState {
  factory StockCountState({
    @Default(false) bool isLoading,
    @Default(false) bool isAlreadySignedIn,
    @Default(false) bool hasError,
    ActionTRAKApiErrorCode? errorCode,
    String? errorMessage,
    @Default(false) bool didFinish,
    UserProfileModel? userProfileModel,
    List<StockCountItemModel>? stockCountItemList,
    String? token,
  }) = _StockCountState;
}
