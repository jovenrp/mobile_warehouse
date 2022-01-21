import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_state.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/domain/repositories/pick_ticket_details_repository.dart';

class PickTicketDetailsBloc extends Cubit<PickTicketDetailsState> {
  PickTicketDetailsBloc({
    required this.pickTicketDetailsRepository,
    required this.persistenceService,
  }) : super(PickTicketDetailsState());

  final PickTicketDetailsRepository pickTicketDetailsRepository;
  final PersistenceService persistenceService;

  Future<void> getPickTicketDetails({String? pickTicketId}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator

    try {
      String? token = await persistenceService.dwnToken.get();
      final PickTicketsDetailsResponse response =
          await pickTicketDetailsRepository.fetchPickTicketsDetails(
              token: token, pickTicketId: pickTicketId);

      emit(state.copyWith(
          isLoading: false,
          pickTicketsResponse: response.pickTicketsResponse,
          hasError: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> updateTicketDetails(
      {List<PickTicketDetailsModel>? pickTicketDetailsModel}) async {
    emit(state.copyWith(isUpdateLoading: true));

    try {
      final PickTicketsDetailsResponse response =
          await pickTicketDetailsRepository.updateTicketDetails(
              pickTicketDetailsModel: pickTicketDetailsModel);
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true));
      print(_);
    }
  }
}
