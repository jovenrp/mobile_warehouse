import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/item_lookup/bloc/item_lookup_state.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_alias_model.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_lookup_response.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_stock_model.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_trak_model.dart';
import 'package:mobile_warehouse/presentation/item_lookup/domain/item_lookup_repository.dart';

class ItemLookupBloc extends Cubit<ItemLookupState> {
  ItemLookupBloc({
    required this.itemLookupRepository,
    required this.persistenceService,
  }) : super(ItemLookupState());

  final ItemLookupRepository itemLookupRepository;
  final PersistenceService persistenceService;

  Future<void> init() async {
    emit(state.copyWith(
        isInit: true,
        isLoading: false,
        itemAlias: <ItemAliasModel>[],
        itemStock: <ItemStockModel>[],
        itemTrak: <ItemTrakModel>[]));
  }

  Future<void> searchItem({String? searchItem, String? value}) async {
    emit(state.copyWith(isLoading: true));
    //value should be stored somewhere
    try {
      String? token = await persistenceService.dwnToken.get();
      final ItemLookupResponse response =
          await itemLookupRepository.lookupItemAlias(token: token, item: value);

      if (response.error == true) {
        await persistenceService.logout();
        emit(state.copyWith(isLoading: false, hasError: true));
      }

      String searchText = searchItem?.toLowerCase() ?? '';
      List<ItemAliasModel> values =
          response.itemAlias?.where((ItemAliasModel item) {
                String id = item.id?.toLowerCase() ?? '';
                String itemId = item.itemId?.toLowerCase() ?? '';
                String itemName = item.itemName?.toLowerCase() ?? '';
                String type = item.type?.toLowerCase() ?? '';
                String note = item.note?.toLowerCase() ?? '';
                String code = item.code?.toLowerCase() ?? '';
                String vendorId = item.code?.toLowerCase() ?? '';
                String vendorName = item.code?.toLowerCase() ?? '';
                return id.contains(searchText) ||
                    itemId.contains((searchText)) ||
                    itemName.contains((searchText)) ||
                    type.contains((searchText)) ||
                    note.contains((searchText)) ||
                    vendorId.contains((searchText)) ||
                    vendorName.contains((searchText)) ||
                    code.contains(searchText);
              }).toList() ??
              <ItemAliasModel>[];

      emit(state.copyWith(
          isLoading: false,
          itemAlias: searchItem?.isEmpty == true ? response.itemAlias : values,
          hasError: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  Future<List<ItemAliasModel>?> lookupItemAlias({String? item}) async {
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
  }

  Future<void> getItemTrakList({String? item}) async {
    emit(state.copyWith(isTrakLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final ItemLookupResponse response =
          await itemLookupRepository.getItemTrakList(token: token, item: item);

      emit(state.copyWith(
          isTrakLoading: false, hasError: false, itemTrak: response.itemTrak));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }
}
