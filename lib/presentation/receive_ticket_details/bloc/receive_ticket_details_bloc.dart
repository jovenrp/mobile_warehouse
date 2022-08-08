import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/bloc/receive_ticket_details_state.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_model.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/domain/repositories/receive_ticket_details_repository.dart';

class ReceiveTicketDetailsBloc extends Cubit<ReceiveTicketDetailsState> {
  ReceiveTicketDetailsBloc({
    required this.receiveTicketDetailsRepository,
    required this.persistenceService,
  }) : super(ReceiveTicketDetailsState());

  final ReceiveTicketDetailsRepository receiveTicketDetailsRepository;
  final PersistenceService persistenceService;

  Future<List<ReceiveTicketDetailsModel>?> getReceiveTicketDetails(
      {String? id}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final ReceiveTicketDetailsResponse response =
          await receiveTicketDetailsRepository.getReceiveTicketDetails(
              token: token, id: id);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          receiveTicketDetailsModel: response.receiveTicketDetailsModel));
      return response.receiveTicketDetailsModel;
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      logger.e(_.toString());
      return <ReceiveTicketDetailsModel>[];
    }
  }

  Future<void> beginReceiveDetail({required String id}) async {
    emit(state.copyWith(isUpdateLoading: true, isCompleteTicket: false));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';

      final String response = await receiveTicketDetailsRepository
          .beginReceiveDetail(id: id, token: sessId);

      emit(state.copyWith(isUpdateLoading: false, hasError: false));
    } catch (_) {
      emit(state.copyWith(
          isUpdateLoading: false, hasError: true, isCompleteTicket: false));
      print(_);
    }
  }

  Future<void> exitReceiveDetail({required String id}) async {
    emit(state.copyWith(isUpdateLoading: true, isCompleteTicket: false));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';

      final String response = await receiveTicketDetailsRepository
          .exitReceiveDetail(id: id, token: sessId);

      emit(state.copyWith(isUpdateLoading: false, hasError: false));
    } catch (_) {
      emit(state.copyWith(
          isUpdateLoading: false, hasError: true, isCompleteTicket: false));
      print(_);
    }
  }

  Future<void> submitPick(
      {String? id,
      required String containerId,
      required String qtyReceived}) async {
    emit(state.copyWith(
        isUpdateLoading: true,
        isCompleteTicket: false,
        dummyQuantityPicked: '',
        dummyPickTicketId: ''));

    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';
      final ReceiveTicketDetailsResponse response =
          await receiveTicketDetailsRepository.submitReceiveDetail(
              token: sessId,
              id: id,
              containerId: containerId,
              qtyReceived: qtyReceived);

      emit(state.copyWith(
          isUpdateLoading: false,
          hasError: false,
          response: response,
          isCompleteTicket: false,
          dummyQuantityPicked: '',
          dummyPickTicketId: ''));
    } catch (_) {
      emit(state.copyWith(
          isUpdateLoading: false,
          hasError: true,
          dummyQuantityPicked: '',
          dummyPickTicketId: ''));
      print(_);
    }
  }

  Future<void> completeReceiveTicket({required String ticketId}) async {
    emit(state.copyWith(isUpdateLoading: true, isCompleteTicket: false));
    try {
      String sessId = await persistenceService.dwnToken.get() ?? '';
      final String response = await receiveTicketDetailsRepository
          .completeReceiveTicket(ticketId: ticketId, token: sessId);

      emit(state.copyWith(
          isUpdateLoading: false, hasError: false, isCompleteTicket: true));
    } catch (_) {
      emit(state.copyWith(
          isUpdateLoading: false, isCompleteTicket: false, hasError: true));
      print(_);
    }
  }

  Future<void> resetStates() async {
    emit(state.copyWith(
        isLoading: false,
        isUpdateLoading: false,
        isCompleteTicket: false,
        isOverPicked: false));
  }

  void setQuantityPicked(ReceiveTicketDetailsModel? receiveTicketDetailsModel,
      TextEditingController controller) {
    String valueItem = controller.text;
    if (valueItem == '0') {
      receiveTicketDetailsModel?.setStatus('Partial');
      receiveTicketDetailsModel?.setPickedItem('0');
    }
    if (receiveTicketDetailsModel?.qtyReceived?.isEmpty == true ||
        receiveTicketDetailsModel?.qtyReceived == null) {
      receiveTicketDetailsModel?.setPickedItem('0');
    }
    emit(state.copyWith(
        dummyReceiveTicketDetailsModel: receiveTicketDetailsModel));
    receiveTicketDetailsModel?.setIsChecked(true);
    controller.clear();
    if ((double.parse(valueItem) +
            double.parse(receiveTicketDetailsModel?.qtyReceived ?? '0')) >
        double.parse(receiveTicketDetailsModel?.qtyOrder ?? '0')) {
      receiveTicketDetailsModel?.setPickedItem((double.parse(valueItem) +
              double.parse(receiveTicketDetailsModel.qtyReceived ?? '0'))
          .toString());
      emit(state.copyWith(
          isOverPicked: true,
          dummyPickTicketId: receiveTicketDetailsModel?.id,
          dummyQuantityPicked: valueItem));
    } else {
      receiveTicketDetailsModel?.setPickedItem((double.parse(valueItem) +
              double.parse(receiveTicketDetailsModel.qtyReceived ?? '0'))
          .toString());
      emit(state.copyWith(
          isOverPicked: false, dummyPickTicketId: '', dummyQuantityPicked: ''));
      //submit pick here
      submitPick(
          id: receiveTicketDetailsModel?.id,
          containerId: receiveTicketDetailsModel?.containerId ?? '',
          qtyReceived: valueItem);
    }

    if (double.parse(receiveTicketDetailsModel?.qtyReceived ?? '0') >
        double.parse(receiveTicketDetailsModel?.qtyOrder ?? '0')) {
      receiveTicketDetailsModel?.setIsOver('Y');
      receiveTicketDetailsModel?.setIsUnder('N');
    } else if (double.parse(receiveTicketDetailsModel?.qtyReceived ?? '0') <
        double.parse(receiveTicketDetailsModel?.qtyOrder ?? '0')) {
      receiveTicketDetailsModel?.setIsOver('N');
      receiveTicketDetailsModel?.setIsUnder('Y');
    } else if (double.parse(receiveTicketDetailsModel?.qtyReceived ?? '0') ==
        double.parse(receiveTicketDetailsModel?.qtyOrder ?? '0')) {
      receiveTicketDetailsModel?.setIsOver('N');
      receiveTicketDetailsModel?.setIsUnder('N');
    }
  }

  String getQuantityText(
      ReceiveTicketDetailsModel? receiveTicketDetailsModel, String textValue) {

    return (receiveTicketDetailsModel?.qtyReceived == null ||
            receiveTicketDetailsModel?.qtyReceived?.isEmpty == true)
        ? '${receiveTicketDetailsModel?.qtyOrder}'
        : receiveTicketDetailsModel?.qtyReceived == null ||
                receiveTicketDetailsModel?.qtyReceived?.isEmpty == true
            ? '${receiveTicketDetailsModel?.qtyReceived} of ${receiveTicketDetailsModel?.qtyOrder}'
            : '${(double.parse(receiveTicketDetailsModel?.qtyReceived?.isNotEmpty == true ? receiveTicketDetailsModel?.qtyReceived ?? '0' : '0') + double.parse(textValue == '' || textValue == '-' ? '0' : textValue)).toStringAsFixed(0)} of ${receiveTicketDetailsModel?.qtyOrder}';
  }

  bool updateCheckBox(ReceiveTicketDetailsModel? receiveTicketDetailsModel,
      bool? value, String? pickTicketId, TextEditingController controller) {
    if (value == true) {
      controller.text = receiveTicketDetailsModel?.qtyOrder ?? '0';
      setQuantityPicked(receiveTicketDetailsModel, controller);
      receiveTicketDetailsModel?.setStatus('Processed');
      receiveTicketDetailsModel?.setIsVisible(false);
      receiveTicketDetailsModel?.setIsChecked(true);
    }
    return false;
  }

  void cancelPickRequest(
      ReceiveTicketDetailsModel? pickTicket, String? valueItem) {
    pickTicket?.setPickedItem((double.parse(pickTicket.pickedItem ?? '0') -
            double.parse(valueItem ?? '0'))
        .toString());
    emit(state.copyWith(
        isOverPicked: false, dummyPickTicketId: '', dummyQuantityPicked: ''));
  }
}
