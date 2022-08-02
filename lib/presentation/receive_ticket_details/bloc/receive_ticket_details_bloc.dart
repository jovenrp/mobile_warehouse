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

  Future<void> getReceiveTicketDetails({String? id}) async {
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
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      logger.e(_.toString());
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

  void setQuantityPicked(ReceiveTicketDetailsModel? receiveTicketDetailsModel,
      TextEditingController controller) {
    String valueItem = controller.text;
    if (valueItem == '0') {
      receiveTicketDetailsModel?.setStatus('Partial');
      receiveTicketDetailsModel?.setPickedItem('0');
    }
    if (receiveTicketDetailsModel?.pickedItem?.isEmpty == true ||
        receiveTicketDetailsModel?.pickedItem == null) {
      receiveTicketDetailsModel?.setPickedItem('0');
    }
    emit(state.copyWith(
        dummyReceiveTicketDetailsModel: receiveTicketDetailsModel));
    receiveTicketDetailsModel?.setIsChecked(true);
    controller.clear();
    if ((double.parse(valueItem) +
            double.parse(receiveTicketDetailsModel?.pickedItem ?? '0')) >
        double.parse(receiveTicketDetailsModel?.qtyOrder ?? '0')) {
      receiveTicketDetailsModel?.setPickedItem((double.parse(valueItem) +
              double.parse(receiveTicketDetailsModel.pickedItem ?? '0'))
          .toString());
      emit(state.copyWith(
          isOverPicked: true,
          dummyPickTicketId: receiveTicketDetailsModel?.id,
          dummyQuantityPicked: valueItem));
    } else {
      receiveTicketDetailsModel?.setPickedItem((double.parse(valueItem) +
              double.parse(receiveTicketDetailsModel.pickedItem ?? '0'))
          .toString());
      emit(state.copyWith(
          isOverPicked: false, dummyPickTicketId: '', dummyQuantityPicked: ''));
      //submit pick here
      /*submitPick(
          pickTicketDetailId: pickTicket?.id ?? '', qtyPicked: valueItem);*/
    }

    if (double.parse(receiveTicketDetailsModel?.pickedItem ?? '0') ==
        double.parse(receiveTicketDetailsModel?.qtyOrder ?? '0')) {
      receiveTicketDetailsModel?.setStatus('Processed');
    } else {
      receiveTicketDetailsModel?.setStatus('Partial');
    }
  }

  String getQuantityText(
      ReceiveTicketDetailsModel? receiveTicketDetailsModel, String textValue) {
    return (receiveTicketDetailsModel?.pickedItem == null ||
            receiveTicketDetailsModel?.pickedItem?.isEmpty == true)
        ? '${receiveTicketDetailsModel?.qtyReceived}'
        : receiveTicketDetailsModel?.pickedItem == null ||
                receiveTicketDetailsModel?.pickedItem?.isEmpty == true
            ? '${receiveTicketDetailsModel?.qtyReceived} of ${receiveTicketDetailsModel?.qtyOrder}'
            : '${(double.parse(receiveTicketDetailsModel?.pickedItem ?? '0') + double.parse(textValue == '' || textValue == '-' ? '0' : textValue)).toStringAsFixed(0)} of ${receiveTicketDetailsModel?.qtyOrder}';
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
}
