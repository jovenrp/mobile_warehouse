import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/services/count_ticket_details_api_service.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/domain/repositories/count_ticket_details_repository.dart';

class CountTicketDetailsRepositoryImpl implements CountTicketDetailsRepository {
  CountTicketDetailsRepositoryImpl(this._apiService);

  final CountTicketDetailsApiService _apiService;

  @override
  Future<CountTicketDetailsReponse> getCountTicketDetails(
      {String? token, String? id}) async {
    try {
      final String result = await _apiService.getCountTicketDetailSummary(token,
          data: '|keys:ticketId=$id');

      final CountTicketDetailsReponse response =
          CountTicketDetailsReponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return CountTicketDetailsReponse(
          error: true,
          message: 'Get count ticket detail summary has an error.');
    }
  }
}
