import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/bloc/count_ticket_skus_state.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/domain/repositories/count_ticket_skus_repository.dart';

class CountTicketSkusBloc extends Cubit<CountTicketSkusState> {
  CountTicketSkusBloc({
    required this.countTicketSkusRepository,
    required this.persistenceService,
  }) : super(CountTicketSkusState());

  final CountTicketSkusRepository countTicketSkusRepository;
  final PersistenceService persistenceService;

  Future<void> getCountTicketDetailSkus({String? id}) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      String? token = await persistenceService.dwnToken.get();
      final CountTicketDetailsReponse response = await countTicketSkusRepository
          .getCountTicketDetailSkus(token: token, id: id);

      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          countTicketDetailModel: response.countTicketDetail));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> beginCount({String? id}) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      String? token = await persistenceService.dwnToken.get();
      final CountTicketDetailsReponse response =
          await countTicketSkusRepository.beginCount(token: token, id: id);

      emit(state.copyWith(
          hasError: false,
          response: response,
          countTicketDetailModel: response.countTicketDetail));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  Future<CountTicketDetailsReponse> exitCount({String? id}) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      String? token = await persistenceService.dwnToken.get();
      final CountTicketDetailsReponse response =
          await countTicketSkusRepository.exitCount(token: token, id: id);

      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          countTicketDetailModel: response.countTicketDetail));
      return response;
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
      return CountTicketDetailsReponse(
          error: true, message: 'error on count ticket details response');
    }
  }
}
