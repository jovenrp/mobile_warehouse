import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/presentation/container_move/bloc/container_move_state.dart';
import 'package:mobile_warehouse/presentation/container_move/domain/repositories/container_move_repository.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/models/stock_yield_response.dart';

class ContainerMoveBloc extends Cubit<ContainerMoveState> {
  ContainerMoveBloc({
    required this.containerMoveRepository,
    required this.persistenceService,
  }) : super(ContainerMoveState());

  final ContainerMoveRepository containerMoveRepository;
  final PersistenceService persistenceService;

  Future<void> init() async {
    emit(state.copyWith(
        isLoading: false,
        isInit: true,
        isDestInit: true,
        isLoadingDestination: false,
        hasError: false,
        containersDestination: <ContainerModel>[],
        containers: <ContainerModel>[]));
  }

  Future<List<ContainerModel>> searchContainer(
      {String? containerNum, bool? isDestination}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final ContainerResponse response = await containerMoveRepository
          .searchContainer(token: token, containerNum: containerNum);

      if (response.error == true) {
        await persistenceService.logout();
        emit(state.copyWith(isLoading: false, hasError: true));
      }

      List<ContainerModel> values =
          response.getContainers?.where((ContainerModel item) {
                String num = item.num?.toLowerCase() ?? '';
                return num.contains(containerNum ?? '');
              }).toList() ??
              <ContainerModel>[];

      if (isDestination == true) {
        emit(state.copyWith(
            isLoadingDestination: false,
            isLoading: false,
            isDestInit: false,
            hasError: false,
            containersDestination: values));
      } else {
        emit(state.copyWith(
            isLoading: false,
            isLoadingDestination: false,
            containersDestination: <ContainerModel>[],
            isInit: false,
            hasError: false,
            containers: values));
      }
      return values;
    } catch (_) {
      emit(state.copyWith(
          isLoading: false, isLoadingDestination: false, hasError: true));
      print(_);
      return <ContainerModel>[];
    }
  }

  Future<void> moveContainer(
      {String? containerNum, String? destinationContainer}) async {
    emit(state.copyWith(isLoading: true)); //turn on loading indicator
    try {
      String? token = await persistenceService.dwnToken.get();
      final StockYieldResponse response =
          await containerMoveRepository.moveContainer(
              token: token,
              containerId: containerNum,
              destContainerId: destinationContainer);

      emit(state.copyWith(
          isLoading: false,
          hasError: response.error ?? false,
          containerMoveResponse: response,
          isMovingSuccess: true));
    } catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, isMovingSuccess: false));
      print(_);
    }
  }
}
