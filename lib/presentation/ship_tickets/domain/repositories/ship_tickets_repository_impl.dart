import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/data/models/ship_tickets_response.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/data/services/ship_tickets_api_service.dart';
import 'package:mobile_warehouse/presentation/ship_tickets/domain/repositories/ship_tickets_repository.dart';

class ShipTicketsRepositoryImpl implements ShipTicketsRepository {
  ShipTicketsRepositoryImpl(this._apiService);

  final ShipTicketsApiService _apiService;

  @override
  Future<ShipTicketsResponse> getShipTickets({String? token}) async {
    try {
      final String result = await _apiService.getShipTickets(token);

      final ShipTicketsResponse response =
          ShipTicketsResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ShipTicketsResponse(
          error: true, message: 'Get ship tickets api has an error.');
    }
  }
}
