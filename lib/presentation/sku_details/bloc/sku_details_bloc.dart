import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/domain/repositories/pick_ticket_details_repository.dart';
import 'package:mobile_warehouse/presentation/sku_details/bloc/sku_details_state.dart';

class SkuDetailsBloc extends Cubit<SkuDetailsState> {
  SkuDetailsBloc({
    required this.pickTicketDetailsRepository,
    required this.persistenceService,
  }) : super(SkuDetailsState());

  final PickTicketDetailsRepository pickTicketDetailsRepository;
  final PersistenceService persistenceService;

  Future<void> getPickTicketDetails({String? pickTicketId}) async {
    emit(state.copyWith(isLoading: true)); //turn
  }
}
