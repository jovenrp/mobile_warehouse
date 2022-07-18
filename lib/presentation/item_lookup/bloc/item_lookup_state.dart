import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_alias_model.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_lookup_response.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_stock_model.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_trak_model.dart';

part 'item_lookup_state.freezed.dart';

@freezed
class ItemLookupState with _$ItemLookupState {
  factory ItemLookupState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(false) bool isInit,
    @Default(false) bool isStockLoading,
    @Default(false) bool isTrakLoading,
    String? errorMessage,
    ItemLookupResponse? response,
    List<ItemAliasModel>? itemAlias,
    List<ItemStockModel>? itemStock,
    List<ItemTrakModel>? itemTrak,
    @Default(false) bool didFinish,
  }) = _ItemLookupState;
}
