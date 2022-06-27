import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_response.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/services/pick_tickets_api_service.dart';

import 'pick_tickets_repository.dart';

class PickTicketsRepositoryImpl implements PickTicketsRepository {
  PickTicketsRepositoryImpl(this._apiService);

  final PickTicketsApiService _apiService;

  @override
  Future<PickTicketsResponse> fetchPickTickets({String? token}) async {
    try {
      final String result = await _apiService.fetchPickTickets(token,
          headers: 'true',
          data: '|keys:ALL|cols:id,num,status,countTicketType as type,isOpen');

      final PickTicketsResponse response =
          PickTicketsResponse.fromJson(jsonDecode(result));

      print(response);

      return response;
    } catch (_) {
      logger.e(_.toString());
      return PickTicketsResponse(
          error: true, message: 'Fetch pick tickets has an error.');
    }
  }
}
