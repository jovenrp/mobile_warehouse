import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/domain/location_mapper_repository.dart';
import 'package:mobile_warehouse/presentation/parent_location/bloc/parent_location_state.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/parent_location_model.dart';

class ParentLocationBloc extends Cubit<ParentLocationState> {
  ParentLocationBloc({
    required this.persistenceService,
    required this.locationMapperRepository,
  }) : super(ParentLocationState());

  final PersistenceService persistenceService;
  final LocationMapperRepository locationMapperRepository;

  Future<void> getContainerChild(String? parentId, String? status) async {
    print('parent location init');
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: ''));

    try {
      String? token = await persistenceService.dwnToken.get();

      ParentLocationModel result;
      if (status == 'children') {
        result = await locationMapperRepository.getContainerChildren(
            token, parentId);
      } else {
        result =
            await locationMapperRepository.getContainerParent(token, parentId);
      }

      print(result.container);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          parentLocationModel: result,
          containerModel: result.container)); //t
    } on DioError catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, errorMessage: 'error'));
    }
  }
}
