import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_response.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/bloc/ship_tickets_state.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/data/models/ship_tickets_response.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/domain/repositories/ship_tickets_repository.dart';

class ShipTicketsBloc extends Cubit<ShipTicketsState> {
  ShipTicketsBloc({
    required this.shipTicketsRepository,
    required this.persistenceService,
  }) : super(ShipTicketsState());

  final ShipTicketsRepository shipTicketsRepository;
  final PersistenceService persistenceService;

  Future<void> getShipTickets({bool? isScreenLoading}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final ShipTicketsResponse response =
          await shipTicketsRepository.getShipTickets(token: token);

      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          shipTicketsModel: response.shipTicketsModel));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      logger.e(_.toString());
    }
  }

  Future<void> searchTicket({String? value}) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await persistenceService.dwnToken.get();
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }
}
