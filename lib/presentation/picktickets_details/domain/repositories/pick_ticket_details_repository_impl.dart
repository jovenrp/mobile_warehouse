import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/services/pick_tickets_api_service.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/domain/repositories/pick_ticket_details_repository.dart';

class PickTicketDetailsRepositoryImpl implements PickTicketDetailsRepository {
  PickTicketDetailsRepositoryImpl(this._apiService);

  final PickTicketsApiService _apiService;

  @override
  Future<PickTicketsDetailsResponse> fetchPickTicketsDetails(
      {String? token, String? pickTicketId}) async {
    try {
      final String result =
          await _apiService.fetchPickTicketsDetails(token, pickTicketId);

      final PickTicketsDetailsResponse response =
          PickTicketsDetailsResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return PickTicketsDetailsResponse();
    }
  }
}