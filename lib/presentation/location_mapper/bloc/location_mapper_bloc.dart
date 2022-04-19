import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_state.dart';
import 'package:mobile_warehouse/presentation/location_mapper/data/models/sku_response.dart';
import 'package:mobile_warehouse/presentation/location_mapper/domain/location_mapper_repository.dart';

class LocationMapperBloc extends Cubit<LocationMapperState> {
  LocationMapperBloc({
    required this.persistenceService,
    required this.locationMapperRepository,
  }) : super(LocationMapperState());

  final PersistenceService persistenceService;
  final LocationMapperRepository locationMapperRepository;

  Future<void> getContainerSkus({String? id}) async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: ''));

    try {
      String? token = await persistenceService.dwnToken.get();
      final SkuResponse result = await locationMapperRepository
          .getContainerSkus(token: token, parentId: id);
      print(result);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          skuResponse: result,
          skus: result.skus)); //t
    } on DioError catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, errorMessage: 'error'));
    }
  }

  Future<void> removeSku({String? id, String? skuId}) async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: ''));

    try {
      String? token = await persistenceService.dwnToken.get();
      final SkuResponse result = await locationMapperRepository.removeSku(
          token: token, id: id, skuId: skuId);
      print(result);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          skuResponse: result,
          skus: result.skus)); //t
    } on DioError catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, errorMessage: 'error'));
    }
  }

  Future<void> addSku({String? id, String? skuId}) async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: ''));

    try {
      String? token = await persistenceService.dwnToken.get();
      final SkuResponse result = await locationMapperRepository.addSku(
          token: token, id: id, skuId: skuId);
      print(result);
      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          skuResponse: result,
          skus: result.skus)); //t
    } on DioError catch (_) {
      emit(state.copyWith(
          isLoading: false, hasError: true, errorMessage: 'error'));
    }
  }
}
