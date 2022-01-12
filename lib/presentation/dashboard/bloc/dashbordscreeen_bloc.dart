import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashboardscreen_state.dart';

class DashboardScreenBloc extends Cubit<DashboardScreenState> {
  DashboardScreenBloc({
    required this.persistenceService,
  }) : super(DashboardScreenState());

  final PersistenceService persistenceService;
}
