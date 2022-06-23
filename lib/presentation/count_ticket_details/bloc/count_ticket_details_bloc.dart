import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/bloc/count_ticket_details_state.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/domain/repositories/count_ticket_details_repository.dart';

class CountTicketDetailsBloc extends Cubit<CountTicketDetailsState> {
  CountTicketDetailsBloc({
    required this.countTicketDetailsRepository,
    required this.persistenceService,
  }) : super(CountTicketDetailsState());

  final CountTicketDetailsRepository countTicketDetailsRepository;
  final PersistenceService persistenceService;

  Future<void> getCountTicketDetails({String? id}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final CountTicketDetailsReponse response =
          await countTicketDetailsRepository.getCountTicketDetails(
              token: token, id: id);

      print(response);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          response: response,
          countTicketDetailSummaryModel: response.countTicketDetailSummary));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }
}
