import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/item_lookup/domain/item_lookup_repository.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/bloc/stock_adjust_state.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_model.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_response.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_item_model.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/domain/repositories/stock_adjust_repository.dart';

class StockAdjustBloc extends Cubit<StockAdjustState> {
  StockAdjustBloc({
    required this.stockAdjustRepository,
    required this.itemLookupRepository,
    required this.persistenceService,
  }) : super(StockAdjustState());

  final StockAdjustRepository stockAdjustRepository;
  final ItemLookupRepository itemLookupRepository;
  final PersistenceService persistenceService;

  Future<void> init() async {
    emit(state.copyWith(
        isLoading: false,
        isStockLoading: false,
        isAdjustLoading: false,
        hasError: false,
        stockModel: <StockAdjustModel>[],
        stockItems: <StockItemModel>[]));
  }

  Future<List<StockAdjustModel>?> stockAdjust(
      {String? containerId,
      String? qty,
      String? sku,
      required bool absolute}) async {
    emit(state.copyWith(isAdjustLoading: true));
    try {
      String? token = await persistenceService.dwnToken.get();
      final StockAdjustResponse response =
          await stockAdjustRepository.stockAdjust(
              token: token,
              containerId: containerId,
              sku: sku,
              qty: qty,
              absolute: absolute);

      emit(state.copyWith(
        isAdjustLoading: false,
        hasError: false,
      ));
      return response.stockAdjust;
    } catch (_) {
      emit(state.copyWith(isAdjustLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> stockLookUp({String? sku, String? locNum}) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await persistenceService.dwnToken.get();
      final StockAdjustResponse response = await stockAdjustRepository
          .stockLookUp(token: token, sku: sku, locNum: locNum);

      emit(state.copyWith(
        isLoading: false,
        hasError: false,
        stockItems: response.stockItems,
      ));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  /*Future<List<ItemAliasModel>?> lookupItemAlias({String? item}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final ItemLookupResponse response =
          await itemLookupRepository.lookupItemAlias(token: token, item: item);

      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          itemAlias: response.itemAlias));
      return response.itemAlias;
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> lookupBarcodeStock({String? item}) async {
    emit(state.copyWith(isStockLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final ItemLookupResponse response = await itemLookupRepository
          .lookupBarcodeStock(token: token, item: item);

      emit(state.copyWith(
          isStockLoading: false,
          hasError: false,
          itemStock: response.itemStock));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }*/
}
