import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_lookup_response.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/services/item_lookup_api_service.dart';
import 'package:mobile_warehouse/presentation/item_lookup/domain/item_lookup_repository.dart';

class ItemLookupRepositoryImpl implements ItemLookupRepository {
  ItemLookupRepositoryImpl(this._apiService);

  final ItemLookupApiService _apiService;

  @override
  Future<ItemLookupResponse> lookupBarcodeStock(
      {String? token, String? item, String? param}) async {
    try {
      final String result =
          await _apiService.getItemStockList(token, data: item);

      final ItemLookupResponse response =
          ItemLookupResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ItemLookupResponse(
          error: true, message: 'Get count tickets has an error.');
    }
  }

  @override
  Future<ItemLookupResponse> lookupItemAlias(
      {String? token, String? item, String? param}) async {
    try {
      final String result =
          await _apiService.lookupItemAlias(token, data: '$item');

      final ItemLookupResponse response =
          ItemLookupResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ItemLookupResponse(
          error: true, message: 'Get count tickets has an error.');
    }
  }

  @override
  Future<ItemLookupResponse> getItemTrakList(
      {String? token, String? item, String? param}) async {
    try {
      final String result =
          await _apiService.getItemTrakList(token, data: '$item');

      final ItemLookupResponse response =
          ItemLookupResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ItemLookupResponse(
          error: true, message: 'Get count tickets has an error.');
    }
  }
}
