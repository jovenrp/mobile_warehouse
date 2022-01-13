import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashboardscreen_state.dart';

class DashboardScreenBloc extends Cubit<DashboardScreenState> {
  DashboardScreenBloc({
    required this.persistenceService,
  }) : super(DashboardScreenState());

  final PersistenceService? persistenceService;
  Future<void> logout() async {
    emit(state.copyWith(isLoading: true));

    try {
      await persistenceService?.logout();
      String? token = await persistenceService?.dwnToken.get();
      if (token == null) {
        emit(state.copyWith(isSignedOut: true));
      }
      emit(state.copyWith(isLoading: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
      logger.e(_);
    }
  }
}
