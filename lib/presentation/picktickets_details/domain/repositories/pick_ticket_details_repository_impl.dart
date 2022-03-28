import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/ticket_details_response_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/services/pick_ticket_details_api_service.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/domain/repositories/pick_ticket_details_repository.dart';

class PickTicketDetailsRepositoryImpl implements PickTicketDetailsRepository {
  PickTicketDetailsRepositoryImpl(this._apiService);

  final PickTicketDetailsApiService _apiService;

  @override
  Future<PickTicketsDetailsResponse> fetchPickTicketsDetails(
      {String? token, String? pickTicketId}) async {
    try {
      final String result = await _apiService.fetchPickTicketsDetails(
          token, '|keys:id=$pickTicketId');

      final PickTicketsDetailsResponse response =
          PickTicketsDetailsResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return PickTicketsDetailsResponse();
    }
  }

  @override
  Future<TicketDetailsResponseModel> beginPick(
      {required String pickTicketDetailId, required String sessId}) async {
    try {
      final String result = await _apiService.beginPick(
          pickTicketDetailId: '|keys:pickTicketDetailId=$pickTicketDetailId',
          sessId: sessId);

      final TicketDetailsResponseModel response =
          TicketDetailsResponseModel.fromJson(jsonDecode(result));
      return response;
    } catch (_) {
      logger.e(_.toString());
      return TicketDetailsResponseModel();
    }
  }

  @override
  Future<TicketDetailsResponseModel> submitPick(
      {required String pickTicketDetailId,
      required String qtyPicked,
      required String sessId}) async {
    try {
      final String result = await _apiService.submitPick(
          pickTicketDetailId:
              '|keys:pickTicketDetailId=$pickTicketDetailId|vals:qtyPicked=$qtyPicked',
          qtyPicked: '|vals:qtyPicked=$qtyPicked',
          sessId: sessId);
      final TicketDetailsResponseModel response =
          TicketDetailsResponseModel.fromJson(jsonDecode(result));
      return response;
    } catch (_) {
      return TicketDetailsResponseModel();
    }
  }

  @override
  Future<TicketDetailsResponseModel> exitPick(
      {required String pickTicketDetailId, required String sessId}) async {
    try {
      final String result = await _apiService.exitPick(
          pickTicketDetailId: '|keys:id=$pickTicketDetailId', sessId: sessId);
      final TicketDetailsResponseModel response =
          TicketDetailsResponseModel.fromJson(jsonDecode(result));
      return response;
    } catch (_) {
      return TicketDetailsResponseModel();
    }
  }

  @override
  Future<TicketDetailsResponseModel> completePickTicket(
      {required String pickTicket, required String sessId}) async {
    try {
      final String result = await _apiService.completePickTicket(
          pickTicketId: '|keys:id=$pickTicket', sessId: sessId);

      final TicketDetailsResponseModel response =
          TicketDetailsResponseModel.fromJson(jsonDecode(result));
      return response;
    } catch (_) {
      return TicketDetailsResponseModel();
    }
  }

  @override
  Future<TicketDetailsResponseModel> exitPickTicket(
      {required String pickTicket, required String sessId}) async {
    try {
      final String result = await _apiService.exitPickTicket(
          pickTicket: pickTicket, sessId: sessId);
      final TicketDetailsResponseModel response =
          TicketDetailsResponseModel.fromJson(jsonDecode(result));
      return response;
    } catch (_) {
      return TicketDetailsResponseModel();
    }
  }
}
