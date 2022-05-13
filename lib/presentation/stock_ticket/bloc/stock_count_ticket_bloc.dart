import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/stock_count/data/models/stock_count_response.dart';
import 'package:mobile_warehouse/presentation/stock_count/domain/repositories/stock_count_repository.dart';
import 'package:mobile_warehouse/presentation/stock_ticket/bloc/stock_count_ticket_state.dart';

class StockCountTicketBloc extends Cubit<StockCountTicketState> {
  StockCountTicketBloc(
      {required this.stockCountRepository, required this.persistenceService})
      : super(StockCountTicketState());

  final StockCountRepository stockCountRepository;
  final PersistenceService persistenceService;

  Future<void> searchStock({String? value}) async {}
  Future<void> getStockCounts({String? value}) async {}
}
