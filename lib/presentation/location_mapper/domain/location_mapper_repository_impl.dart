import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/location_mapper/data/services/location_mapper_api_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/domain/location_mapper_repository.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/parent_location_model.dart';

class LocationMapperRepositoryImpl implements LocationMapperRepository {
  LocationMapperRepositoryImpl(this._apiService);

  final LocationMapperApiService _apiService;
  @override
  Future<String> getDropDown() async {
    return 'asidlnkas';
  }

  @override
  Future<ParentLocationModel> getContainerChildren(
      String? token, String? parentId) async {
    try {
      final String result = await _apiService.getContainerChildren(token,
          headers: 'true', data: '|keys:id=$parentId');

      final ParentLocationModel response =
          ParentLocationModel.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ParentLocationModel();
    }
  }

  @override
  Future<ParentLocationModel> getContainerParent(
      String? token, String? parentId) async {
    try {
      final String result = await _apiService.getContainerParent(token,
          headers: 'true', data: '|keys:id=$parentId');

      final ParentLocationModel response =
          ParentLocationModel.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ParentLocationModel();
    }
  }

  @override
  Future<String> createLocation(
      {String? token, String? parentId, String? name, String? code}) async {
    try {
      final String result = await _apiService.createLocation(token,
          headers: 'true',
          data: '|vals:parentId=$parentId^name=$name^code=$code');

      print(result);
      return '';
    } catch (_) {
      logger.e(_.toString());
      return '';
    }
  }

  @override
  Future<String> getContainerSkus({String? token, String? parentId}) async {
    try {
      final String result = await _apiService.getContainerSkus(token,
          headers: 'true', data: '|data:id=$parentId');

      print(result);
      /*final String response =
      ParentLocationModel.fromJson(jsonDecode(result));*/
      return '';
    } catch (_) {
      logger.e(_.toString());
      return '';
    }
  }
}
