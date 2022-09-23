import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/pack_tickets/data/models/pack_tickets_response.dart';
import 'package:mobile_warehouse/presentation/pack_tickets/data/services/pack_tickets_api_service.dart';

import 'pack_tickets_repository.dart';

class PackTicketsRepositoryImpl implements PackTicketsRepository {
  PackTicketsRepositoryImpl(this._apiService);

  final PackTicketsApiService _apiService;

  @override
  Future<PackTicketsResponse> getPackTickets({String? token}) async {
    try {
      final String result = await _apiService.getPackTickets(token);

      final PackTicketsResponse response =
          PackTicketsResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return PackTicketsResponse(
          error: true, message: 'Get pack tickets api has an error.');
    }
  }
}
