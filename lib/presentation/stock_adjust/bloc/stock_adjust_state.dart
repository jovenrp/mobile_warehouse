import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_alias_model.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_lookup_response.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_stock_model.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_model.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_response.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_item_model.dart';

part 'stock_adjust_state.freezed.dart';

@freezed
class StockAdjustState with _$StockAdjustState {
  factory StockAdjustState(
      {@Default(false) bool isLoading,
      @Default(false) bool isStockLoading,
      @Default(false) bool isAdjustLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      ItemLookupResponse? response,
      StockAdjustResponse? stockAdjustResponse,
      List<StockAdjustModel>? stockModel,
      List<StockItemModel>? stockItems,
      @Default(false) bool didFinish,
      String? token}) = _StockAdjustState;
}
