import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_warehouse/core/domain/models/errors/actiontrak_api_error.dart';
import 'package:mobile_warehouse/presentation/location_mapper/data/models/sku_model.dart';
import 'package:mobile_warehouse/presentation/location_mapper/data/models/sku_response.dart';

part 'location_mapper_state.freezed.dart';

@freezed
class LocationMapperState with _$LocationMapperState {
  factory LocationMapperState(
      {@Default(false) bool isLoading,
      @Default(false) bool isUpdateContainerLoading,
      @Default(false) bool hasError,
      ActionTRAKApiErrorCode? errorCode,
      String? errorMessage,
      String? updateContainerMessage,
      SkuResponse? skuResponse,
      List<SkuModel>? skus,
      @Default(false) bool didFinish,
      String? token}) = _LocationMapperState;
}
