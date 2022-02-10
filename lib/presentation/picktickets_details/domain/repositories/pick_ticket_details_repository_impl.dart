import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/services/pick_ticket_details_api_service.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/domain/repositories/pick_ticket_details_repository.dart';

class PickTicketDetailsRepositoryImpl implements PickTicketDetailsRepository {
  PickTicketDetailsRepositoryImpl(this._apiService);

  final PickTicketDetailsApiService _apiService;

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

  @override
  Future<String> beginPick(
      {required String pickTicketDetailId, required String sessId}) async {
    try {
      final String result = await _apiService.beginPick(
          pickTicketDetailId: pickTicketDetailId, sessId: sessId);
      print('result here $result');
      return '';
    } catch (_) {
      logger.e(_.toString());
      return '';
    }
  }

  @override
  Future<String> submitPick(
      {required String pickTicketDetailId, required String qtyPicked}) async {
    try {
      final String result = await _apiService.submitPick(
          pickTicketDetailId: pickTicketDetailId, qtyPicked: qtyPicked);
      return '';
    } catch (_) {
      return '';
    }
  }

  @override
  Future<String> exitPick({required String pickTicketDetailId}) async {
    try {
      final String result =
          await _apiService.exitPick(pickTicketDetailId: pickTicketDetailId);
      return '';
    } catch (_) {
      return '';
    }
  }

  @override
  Future<String> completePickTicket({required String pickTicket}) async {
    try {
      final String result =
          await _apiService.completePickTicket(pickTicket: pickTicket);
      return '';
    } catch (_) {
      return '';
    }
  }

  @override
  Future<String> exitPickTicket({required String pickTicket}) async {
    try {
      final String result =
          await _apiService.exitPickTicket(pickTicket: pickTicket);
      return '';
    } catch (_) {
      return '';
    }
  }
}
