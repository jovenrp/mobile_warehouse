import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/bloc/receive_tickets_state.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_response.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/domain/repositories/receive_tickets_repository.dart';

class ReceiveTicketsBloc extends Cubit<ReceiveTicketsState> {
  ReceiveTicketsBloc({
    required this.receiveTicketsRepository,
    required this.persistenceService,
  }) : super(ReceiveTicketsState());

  final ReceiveTicketsRepository receiveTicketsRepository;
  final PersistenceService persistenceService;

  Future<void> getReceiveTickets({bool? isScreenLoading}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final ReceiveTicketsResponse response =
          await receiveTicketsRepository.getReceiveTickets(token: token);

      print(response.receiveTicketsModel);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          receiveTicketsModel: response.receiveTicketsModel));
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
