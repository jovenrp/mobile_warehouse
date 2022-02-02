import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_state.dart';

class LocationMapperBloc extends Cubit<LocationMapperState> {
  LocationMapperBloc({
    required this.persistenceService,
  }) : super(LocationMapperState());

  final PersistenceService persistenceService;
}
