import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_response.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/services/pick_tickets_api_service.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';

import 'pick_tickets_repository.dart';

class PickTicketsRepositoryImpl implements PickTicketsRepository {
  PickTicketsRepositoryImpl(this._apiService);

  final PickTicketsApiService _apiService;

  @override
  Future<PickTicketsResponse> fetchPickTickets({String? token}) async {
    try {
      final String result =
          await _apiService.fetchPickTickets(token, headers: 'true');

      final PickTicketsResponse response =
          PickTicketsResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return PickTicketsResponse();
    }
  }
}
