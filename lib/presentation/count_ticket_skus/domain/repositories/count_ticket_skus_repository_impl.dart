import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/data/services/count_ticket_skus_api_service.dart';

import 'count_ticket_skus_repository.dart';

class CountTicketSkusRepositoryImpl implements CountTicketSkusRepository {
  CountTicketSkusRepositoryImpl(this._apiService);

  final CountTicketSkusApiService _apiService;

  @override
  Future<CountTicketDetailsReponse> getCountTicketSkus(
      {String? token, String? id}) {
    // TODO: implement getCountTicketSkus
    throw UnimplementedError();
  }

  @override
  Future<CountTicketDetailsReponse> beginCount(
      {String? token, String? id}) async {
    try {
      final String result = await _apiService.beginCount(token,
          data: 'keys:countTicketDetailId=$id');

      final CountTicketDetailsReponse response =
          CountTicketDetailsReponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return CountTicketDetailsReponse();
    }
  }

  @override
  Future<CountTicketDetailsReponse> exitCount(
      {String? token, String? id}) async {
    try {
      final String result = await _apiService.exitCount(token,
          data: 'keys:countTicketDetailId=$id');

      final CountTicketDetailsReponse response =
          CountTicketDetailsReponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return CountTicketDetailsReponse();
    }
  }
}
