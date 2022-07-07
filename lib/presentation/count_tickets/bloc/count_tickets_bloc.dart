import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/count_tickets/data/models/count_tickets_response.dart';
import 'package:mobile_warehouse/presentation/count_tickets/domain/repositories/count_tickets_repository.dart';

import 'count_tickets_state.dart';

class CountTicketsBloc extends Cubit<CountTicketsState> {
  CountTicketsBloc({
    required this.countTicketsRepository,
    required this.persistenceService,
  }) : super(CountTicketsState());

  final CountTicketsRepository countTicketsRepository;
  final PersistenceService persistenceService;

  Future<void> getCountTickets() async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final CountTicketsReponse response =
          await countTicketsRepository.getCountTickets(token: token);

      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          countTickets: response.countTickets));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }
}
