import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_response.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/services/receive_tickets_api_service.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/domain/repositories/receive_tickets_repository.dart';

class ReceiveTicketsRepositoryImpl implements ReceiveTicketsRepository {
  ReceiveTicketsRepositoryImpl(this._apiService);

  final ReceiveTicketsApiService _apiService;

  @override
  Future<ReceiveTicketsResponse> getReceiveTickets({String? token}) async {
    try {
      final String result = await _apiService.getReceiveTickets(token);

      final ReceiveTicketsResponse response =
          ReceiveTicketsResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ReceiveTicketsResponse(
          error: true, message: 'Get receive tickets api has an error.');
    }
  }
}
