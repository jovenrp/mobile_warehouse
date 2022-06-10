import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/count_tickets/data/models/count_tickets_response.dart';
import 'package:mobile_warehouse/presentation/count_tickets/data/services/count_tickets_api_service.dart';

import 'count_tickets_repository.dart';

class CountTicketsRepositoryImpl implements CountTicketsRepository {
  CountTicketsRepositoryImpl(this._apiService);

  final CountTicketsApiService _apiService;

  @override
  Future<CountTicketsReponse> getCountTickets({String? token}) async {
    try {
      final String result = await _apiService.getCountTickets(token);

      final CountTicketsReponse response =
          CountTicketsReponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return CountTicketsReponse();
    }
  }
}
