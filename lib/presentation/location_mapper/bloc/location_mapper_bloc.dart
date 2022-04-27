import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_state.dart';
import 'package:mobile_warehouse/presentation/location_mapper/data/models/sku_response.dart';
import 'package:mobile_warehouse/presentation/location_mapper/domain/location_mapper_repository.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/parent_location_model.dart';

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

      emit(state.copyWith(
          isLoading: false,
          hasError: false,
          skuResponse: result,
          skus: result.skus));
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

  Future<ParentLocationModel> updateContainer(
      {String? id, String? code, String? serial}) async {
    emit(state.copyWith(
        isUpdateContainerLoading: true, hasError: false, errorMessage: ''));

    try {
      String? token = await persistenceService.dwnToken.get();
      final ParentLocationModel result = await locationMapperRepository
          .updateContainer(token: token, id: id, code: code, serial: serial);
      String message = '';
      if (result.message?.toLowerCase() == 'success') {
        message = result.container?.first.name?.isNotEmpty == true
            ? '${result.container?.first.name} now has serial ${result.container?.first.num}'
            : '${result.container?.first.code} now has serial ${result.container?.first.num}';
        result.message = message;
      }
      emit(state.copyWith(
          isUpdateContainerLoading: false,
          hasError: false,
          updateContainerMessage: message));
      return result;
    } on DioError catch (_) {
      emit(state.copyWith(
          isUpdateContainerLoading: false,
          hasError: true,
          errorMessage: 'error'));
      return ParentLocationModel();
    }
  }
}
