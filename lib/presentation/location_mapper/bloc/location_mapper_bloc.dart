import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_state.dart';
import 'package:mobile_warehouse/presentation/location_mapper/domain/location_mapper_repository.dart';

class LocationMapperBloc extends Cubit<LocationMapperState> {
  LocationMapperBloc({
    required this.persistenceService,
    required this.locationMapperRepository,
  }) : super(LocationMapperState());

  final PersistenceService persistenceService;
  final LocationMapperRepository locationMapperRepository;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: ''));

    try {
      final String result = await locationMapperRepository.getDropDown();
      print(result);
      emit(state.copyWith(isLoading: false, hasError: false)); //t
    } on DioError catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, errorMessage: 'error'));
    }
  }
}
