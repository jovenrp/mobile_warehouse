import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/domain/location_mapper_repository.dart';
import 'package:mobile_warehouse/presentation/parent_location/bloc/parent_location_state.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/container_model.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/parent_location_model.dart';

class ParentLocationBloc extends Cubit<ParentLocationState> {
  ParentLocationBloc({
    required this.persistenceService,
    required this.locationMapperRepository,
  }) : super(ParentLocationState());

  final PersistenceService persistenceService;
  final LocationMapperRepository locationMapperRepository;

  Future<void> getContainerChild(String? parentId, String? status, ContainerModel? containerModel) async {
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

      ContainerModel? originalContainerModel = containerModel;
      print(containerModel?.code);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          parentLocationModel: result,
          containerModel: result.container?.isNotEmpty == true ? result.container : <ContainerModel>[originalContainerModel ?? ContainerModel()]));
    } on DioError catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, errorMessage: 'error'));
    }
  }
}
