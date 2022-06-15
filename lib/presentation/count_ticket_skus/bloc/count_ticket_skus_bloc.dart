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

  Future<void> getCountTicketDetails({String? id}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final CountTicketDetailsReponse response = await countTicketSkusRepository
          .getCountTicketSkus(token: token, id: id);

      print(response);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          countTicketDetailsModel: response.countTicketDetails));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }
}
