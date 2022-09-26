import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/models/container_response.dart';
import 'package:mobile_warehouse/presentation/stock_move/bloc/stock_move_state.dart';
import 'package:mobile_warehouse/presentation/stock_move/data/models/stock_yield_response.dart';
import 'package:mobile_warehouse/presentation/stock_move/domain/repositories/stock_move_repository.dart';

class StockMoveBloc extends Cubit<StockMoveState> {
  StockMoveBloc({
    required this.stockMoveRepository,
    required this.persistenceService,
  }) : super(StockMoveState());

  final StockMoveRepository stockMoveRepository;
  final PersistenceService persistenceService;

  Future<void> init() async {
    emit(state.copyWith(
        isLoading: false,
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
      final ContainerResponse response = await stockMoveRepository
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
            hasError: false,
            containersDestination: values));
      } else {
        emit(state.copyWith(
            isLoading: false,
            isLoadingDestination: false,
            containersDestination: <ContainerModel>[],
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

  Future<void> stockMove(
      {String? containerIdFrom,
      String? qty,
      String? sku,
      String? containerIdTo}) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await persistenceService.dwnToken.get();
      final StockYieldResponse response = await stockMoveRepository.stockMove(
          token: token,
          sourceStockId: containerIdFrom,
          destContainerId: containerIdTo,
          sku: sku,
          qty: qty);

      emit(state.copyWith(
          isLoading: false,
          hasError: response.error ?? false,
          response: response,
          isMovingSuccess: true));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
      print(_);
    }
  }
}
