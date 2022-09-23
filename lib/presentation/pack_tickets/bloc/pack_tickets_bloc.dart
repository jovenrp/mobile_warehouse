import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/pack_tickets/bloc/pack_tickets_state.dart';
import 'package:mobile_warehouse/presentation/pack_tickets/data/models/pack_tickets_response.dart';
import 'package:mobile_warehouse/presentation/pack_tickets/domain/pack_tickets_repository.dart';

class PackTicketsBloc extends Cubit<PackTicketsState> {
  PackTicketsBloc({
    required this.packTicketsRepository,
    required this.persistenceService,
  }) : super(PackTicketsState());

  final PackTicketsRepository packTicketsRepository;
  final PersistenceService persistenceService;

  Future<void> getPackTickets({bool? isScreenLoading}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final PackTicketsResponse response =
          await packTicketsRepository.getPackTickets(token: token);

      if (response.error == true) {
        await persistenceService.logout();
        emit(state.copyWith(isLoading: false, hasError: true));
      }
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          packTicketsModel: response.packTicketsModel));
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
