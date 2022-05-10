import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/stock_count/bloc/stock_count_state.dart';
import 'package:mobile_warehouse/presentation/stock_count/data/models/stock_count_response.dart';
import 'package:mobile_warehouse/presentation/stock_count/domain/repositories/stock_count_repository.dart';

class StockCountBloc extends Cubit<StockCountState> {
  StockCountBloc({required this.stockCountRepository, required this.persistenceService})
      : super(StockCountState());

  final StockCountRepository stockCountRepository;
  final PersistenceService persistenceService;

  Future<void> searchStock({String? value}) async {}
  Future<void> getStockCounts({String? value}) async {
    emit(state.copyWith(
        isLoading: true));

    String? token = await persistenceService.dwnToken.get();
    StockCountResponse response = await stockCountRepository.fetchStockCounts(token: token, pickTicketId: '');

    print(response);
    emit(state.copyWith(
        isLoading: false, stockCountItemList: response.stockCounts, hasError: false));
  }
}
