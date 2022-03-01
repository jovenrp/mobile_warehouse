import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/picktickets/bloc/pick_tickets_state.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_item_model.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_response.dart';
import 'package:mobile_warehouse/presentation/picktickets/domain/repositories/pick_tickets_repository.dart';

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

      List<PickTicketsItemModel> sorted = response.pickTickets ?? <PickTicketsItemModel>[];
      sorted.sort((PickTicketsItemModel? a, PickTicketsItemModel? b){
        String aa = a?.location ?? '';
        String bb = b?.location ?? '';
        return aa.toLowerCase().compareTo(bb.toLowerCase());
      });

      emit(state.copyWith(
          isLoading: false,
          pickTicketsItemModel: sorted,
          hasError: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> searchTicket({String? value}) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await persistenceService.dwnToken.get();
      final PickTicketsResponse response =
          await pickTicketsRepository.fetchPickTickets(token: token);

      String searchText = value?.toLowerCase() ?? '';
      List<PickTicketsItemModel> values =
          response.pickTickets?.where((PickTicketsItemModel item) {
                String ticketId = item.num?.toLowerCase() ?? '';
                String status = item.status?.toLowerCase() ?? '';
                String location = item.location?.toLowerCase() ?? '';
                return ticketId.contains(searchText) ||
                    status.contains((searchText)) ||
                    location.contains(searchText);
              }).toList() ??
              <PickTicketsItemModel>[];

      emit(state.copyWith(
          isLoading: false,
          pickTicketsItemModel:
              value?.isEmpty == true ? response.pickTickets : values,
          hasError: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }
}
