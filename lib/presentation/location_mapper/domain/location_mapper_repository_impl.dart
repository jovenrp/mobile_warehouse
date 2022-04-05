import 'package:mobile_warehouse/presentation/location_mapper/data/services/location_mapper_api_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/domain/location_mapper_repository.dart';

class LocationMapperRepositoryImpl implements LocationMapperRepository {
  LocationMapperRepositoryImpl(this._apiService);

  final LocationMapperApiService _apiService;
  @override
  Future<String> getDropDown() async {
    return 'asidlnkas';
  }
}
