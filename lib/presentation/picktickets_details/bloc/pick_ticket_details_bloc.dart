import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_state.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/ticket_details_response_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/domain/repositories/pick_ticket_details_repository.dart';

class PickTicketDetailsBloc extends Cubit<PickTicketDetailsState> {
  PickTicketDetailsBloc({
    required this.pickTicketDetailsRepository,
    required this.persistenceService,
  }) : super(PickTicketDetailsState());

  final PickTicketDetailsRepository pickTicketDetailsRepository;
  final PersistenceService persistenceService;

  Future<void> resetStates() async {
    emit(state.copyWith(isLoading: false, isUpdateLoading: false, isCompleteTicket: false));
  }

  Future<List<PickTicketDetailsModel>?> getPickTicketDetails({String? pickTicketId}) async {
    emit(state.copyWith(isLoading: true, isCompleteTicket: false)); //turn on loading indicator

    try {
      String? token = await persistenceService.dwnToken.get();
      final PickTicketsDetailsResponse response = await pickTicketDetailsRepository.fetchPickTicketsDetails(token: token, pickTicketId: pickTicketId);

      emit(state.copyWith(
          isLoading: false, pickTicketsResponse: response.pickTicketsResponse, pickTicketResponse: response.pickTicketResponse, hasError: false));
      return response.pickTicketsResponse;
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true, isCompleteTicket: false));
      print(_);
    }
  }

  Future<void> beginPick({required String pickTicketDetailId}) async {
    emit(state.copyWith(isUpdateLoading: true, isCompleteTicket: false));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';

      final TicketDetailsResponseModel response = await pickTicketDetailsRepository.beginPick(pickTicketDetailId: pickTicketDetailId, sessId: sessId);

      emit(state.copyWith(isUpdateLoading: false, hasError: false, ticketDetailsResponseModel: response));
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true, isCompleteTicket: false));
      print(_);
    }
  }

  Future<void> exitPick({required String pickTicketDetailId}) async {
    emit(state.copyWith(isUpdateLoading: true, isCompleteTicket: false));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';
      final TicketDetailsResponseModel response = await pickTicketDetailsRepository.exitPick(pickTicketDetailId: pickTicketDetailId, sessId: sessId);

      emit(state.copyWith(isUpdateLoading: false, hasError: false, ticketDetailsResponseModel: response));
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true, isCompleteTicket: false));
      print(_);
    }
  }

  Future<void> submitPick({required String pickTicketDetailId, required String qtyPicked}) async {
    emit(state.copyWith(isUpdateLoading: true, isCompleteTicket: false));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';
      final TicketDetailsResponseModel response =
          await pickTicketDetailsRepository.submitPick(pickTicketDetailId: pickTicketDetailId, qtyPicked: qtyPicked, sessId: sessId);

      emit(state.copyWith(isUpdateLoading: false, hasError: false, ticketDetailsResponseModel: response, isCompleteTicket: false));
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> completePickTicket({required String pickTicket}) async {
    emit(state.copyWith(isUpdateLoading: true, isCompleteTicket: false));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';
      final TicketDetailsResponseModel response = await pickTicketDetailsRepository.completePickTicket(pickTicket: pickTicket, sessId: sessId);

      emit(state.copyWith(isUpdateLoading: false, hasError: false, isCompleteTicket: true, ticketDetailsResponseModel: response));
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, isCompleteTicket: false, hasError: true));
      print(_);
    }
  }

  Future<void> exitPickTicket({required String pickTicket}) async {
    emit(state.copyWith(isUpdateLoading: true, isCompleteTicket: false));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';
      final TicketDetailsResponseModel response = await pickTicketDetailsRepository.exitPickTicket(pickTicket: pickTicket, sessId: sessId);
      emit(state.copyWith(isUpdateLoading: false, hasError: false, ticketDetailsResponseModel: response));
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true, isCompleteTicket: false));
      print(_);
    }
  }

  Future<void> getSettings() async {
    bool pickLimitSetting = await persistenceService.pickLimitSetting.get() ?? false;
    emit(state.copyWith(pickLimitSetting: pickLimitSetting));
  }

  Future<void> searchTicket({String? value, required String pickTicketId}) async {
    emit(state.copyWith(isLoading: true, isCompleteTicket: false));
    try {
      String? token = await persistenceService.dwnToken.get();
      final PickTicketsDetailsResponse response = await pickTicketDetailsRepository.fetchPickTicketsDetails(token: token, pickTicketId: pickTicketId);

      String searchText = value?.toLowerCase() ?? '';
      List<PickTicketDetailsModel> values = response.pickTicketsResponse?.where((PickTicketDetailsModel item) {
            String sku = item.sku?.toLowerCase() ?? '';
            String description = item.description?.toLowerCase() ?? '';
            String locCode = item.locCode?.toLowerCase() ?? '';
            String status = item.status?.toLowerCase() ?? '';
            String uom = item.uom?.toLowerCase() ?? '';
            String qtyPicked = item.qtyPicked?.toLowerCase() ?? '';
            String qtyPick = item.qtyPick?.toLowerCase() ?? '';
            return sku.contains(searchText) ||
                description.contains((searchText)) ||
                status.contains((searchText)) ||
                uom.contains((searchText)) ||
                qtyPicked.contains((searchText)) ||
                qtyPick.contains((searchText)) ||
                locCode.contains(searchText);
          }).toList() ??
          <PickTicketDetailsModel>[];

      print('$value ${values.length}');

      emit(state.copyWith(isLoading: false, pickTicketsResponse: value?.isEmpty == true ? response.pickTicketsResponse : values, hasError: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  String getQuantityText(PickTicketDetailsModel? pickTicket) {
    return pickTicket?.status?.toLowerCase() == 'partial'
        ? '${pickTicket?.pickedItem} of ${pickTicket?.qtyPick}'
        : (pickTicket?.pickedItem == null || pickTicket?.pickedItem?.isEmpty == true)
            ? '${pickTicket?.qtyPick}'
            : pickTicket?.pickedItem == null || pickTicket?.pickedItem?.isEmpty == true
                ? '${pickTicket?.qtyPick} of ${pickTicket?.qtyPick}'
                : '${pickTicket?.pickedItem} of ${pickTicket?.qtyPick}';
  }

  bool updateCheckBox(PickTicketDetailsModel? pickTicket, bool? value, String? pickTicketId) {

    if (value == true) {
      pickTicket?.setPickedItem(pickTicket.qtyPick);
      pickTicket?.setStatus('Proccessed');
      pickTicket?.setIsVisible(false);
      pickTicket?.setIsChecked(true);
      submitPick(pickTicketDetailId: pickTicket?.id ?? '', qtyPicked: pickTicket?.qtyPick ?? '');
    } else {
      if (pickTicket?.isChecked == true && pickTicket?.status?.toLowerCase() == 'partial') {
        //getPickTicketDetails(pickTicketId: pickTicketId);
        pickTicket?.setPickedItem(pickTicket.qtyPick);
        pickTicket?.setStatus('Proccessed');
        pickTicket?.setIsVisible(false);
        pickTicket?.setIsChecked(true);
        submitPick(pickTicketDetailId: pickTicket?.id ?? '', qtyPicked: pickTicket?.qtyPick ?? '');
      } else {
        pickTicket?.setPickedItem('0');
        pickTicket?.setStatus('Parial');
        pickTicket?.setIsVisible(false);
        pickTicket?.setIsChecked(false);
        submitPick(pickTicketDetailId: pickTicket?.id ?? '', qtyPicked: '0');
      }
    }
    return false;
  }
  
  
}
