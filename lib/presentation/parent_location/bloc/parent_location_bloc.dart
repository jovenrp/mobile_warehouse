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

  Future<ParentLocationModel> getContainerChild(
      String? parentId, String? status, ContainerModel? containerModel) async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: ''));

    try {
      String? token = await persistenceService.dwnToken.get();

      ParentLocationModel result;
      ParentLocationModel parent = ParentLocationModel();
      if (status == 'children') {
        result = await locationMapperRepository.getContainerChildren(
            token, parentId);
      } else {
        result =
            await locationMapperRepository.getContainerParent(token, parentId);
        parent = await locationMapperRepository.getContainerParent(
            token, result.container?[0].parentId);
      }

      ContainerModel? originalContainerModel = containerModel;
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          parentLocationModel: result,
          parentContainerModel: parent.container ?? <ContainerModel>[],
          containerModel: result.container?.isNotEmpty == true
              ? result.container
              : <ContainerModel>[originalContainerModel ?? ContainerModel()]));
      return result;
    } on DioError catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, errorMessage: 'error'));
      return ParentLocationModel();
    }
  }

  Future<void> searchCode({String? value, String? parentId}) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await persistenceService.dwnToken.get();
      ParentLocationModel result =
          await locationMapperRepository.getContainerChildren(token, parentId);

      String searchText = value?.toLowerCase() ?? '';
      List<ContainerModel> values =
          result.container?.where((ContainerModel item) {
                String code = item.code?.toLowerCase() ?? '';
                String name = item.name?.toLowerCase() ?? '';
                String num = item.num?.toLowerCase() ?? '';
                return code.contains(searchText) ||
                    name.contains((searchText)) ||
                    num.contains(searchText);
              }).toList() ??
              <ContainerModel>[];

      print(values);
      emit(state.copyWith(
          isLoading: false,
          containerModel: value?.isEmpty == true ? result.container : values,
          hasError: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }

  Future<void> createContainer(
      {String? parentId, String? name, String? code, String? num, ContainerModel? containerModel}) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await persistenceService.dwnToken.get();
      ParentLocationModel parentLocationModel = await locationMapperRepository.createContainer(
          token: token, parentId: parentId, name: name, code: code, num: num);

      if (parentLocationModel.error == false) {
        await getContainerChild(parentId, 'children', containerModel);
      }
    } on DioError catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, errorMessage: 'error'));
    }
  }
}
