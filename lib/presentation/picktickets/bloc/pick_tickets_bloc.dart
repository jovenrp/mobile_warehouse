import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/picktickets/bloc/pick_tickets_state.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_response.dart';
import 'package:mobile_warehouse/presentation/picktickets/domain/repositories/pick_tickets_repository.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';

class PickTicketsBloc extends Cubit<PickTicketsState> {
  PickTicketsBloc({
    required this.pickTicketsRepository,
    required this.persistenceService,
  }) : super(PickTicketsState());

  final PickTicketsRepository pickTicketsRepository;
  final PersistenceService persistenceService;

  Future<void> getPickTickets({bool? isScreenLoading}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final PickTicketsResponse response =
          await pickTicketsRepository.fetchPickTickets(token: token);

      emit(state.copyWith(
          isLoading: false, pickTicketsModel: response, hasError: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }
}
