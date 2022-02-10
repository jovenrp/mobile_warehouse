import 'dart:async';

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
      final PickTicketsDetailsResponse response = await pickTicketDetailsRepository.fetchPickTicketsDetails(token: token, pickTicketId: pickTicketId);

      emit(state.copyWith(
          isLoading: false, pickTicketsResponse: response.pickTicketsResponse, pickTicketResponse: response.pickTicketResponse, hasError: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> beginPick({required String pickTicketDetailId}) async {
    emit(state.copyWith(isUpdateLoading: true));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';
      print('BEGIN pick is called $pickTicketDetailId $sessId');

      /*final String response = await pickTicketDetailsRepository.beginPick(
          pickTicketDetailId: pickTicketDetailId, sessId: sessId);*/
      //print(response);
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> exitPick({required String pickTicketDetailId}) async {
    emit(state.copyWith(isUpdateLoading: true));
    try {
      print('EXIT pick is called $pickTicketDetailId');
      //final String response = await pickTicketDetailsRepository.exitPick(pickTicketDetailId: pickTicketDetailId);
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> submitPick({required String pickTicketDetailId, required String qtyPicked}) async {
    emit(state.copyWith(isUpdateLoading: true));
    try {
      print('SUBMIT pick is called $pickTicketDetailId $qtyPicked');
      //final String response = await pickTicketDetailsRepository.submitPick(pickTicketDetailId: pickTicketDetailId, qtyPicked: qtyPicked);
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> completePickTicket({required String pickTicket}) async {
    emit(state.copyWith(isUpdateLoading: true));
    try {
      print('COMPLETE pick is called $pickTicket');
      //final String response = await pickTicketDetailsRepository.completePickTicket(pickTicket: pickTicket);
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> exitPickTicket({required String pickTicket}) async {
    emit(state.copyWith(isUpdateLoading: true));
    try {
      print('EXIT pick ticket is called $pickTicket');
      //final String response = await pickTicketDetailsRepository.exitPickTicket(pickTicket: pickTicket);
    } catch (_) {
      emit(state.copyWith(isUpdateLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> getSettings() async {
    bool pickLimitSetting = await persistenceService.pickLimitSetting.get() ?? false;
    emit(state.copyWith(pickLimitSetting: pickLimitSetting));
  }

  Future<void> searchTicket({String? value, required String pickTicketId}) async {
    emit(state.copyWith(isLoading: true));
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
}
