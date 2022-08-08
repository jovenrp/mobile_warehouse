import 'dart:convert';

import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/services/receive_ticket_details_api_service.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/domain/repositories/receive_ticket_details_repository.dart';

class ReceiveTicketDetailsRepositoryImpl
    implements ReceiveTicketDetailsRepository {
  ReceiveTicketDetailsRepositoryImpl(this._apiService);

  final ReceiveTicketDetailsApiService _apiService;

  @override
  Future<ReceiveTicketDetailsResponse> getReceiveTicketDetails(
      {String? token, String? id}) async {
    try {
      final String result =
          await _apiService.getReceiveTicket(token, data: '|keys:id=$id');

      final ReceiveTicketDetailsResponse response =
          ReceiveTicketDetailsResponse.fromJson(jsonDecode(result));

      return response;
    } catch (_) {
      logger.e(_.toString());
      return ReceiveTicketDetailsResponse(
          error: true, message: 'Get receive ticket details api has an error.');
    }
  }

  @override
  Future<String> beginReceiveDetail({String? token, String? id}) async {
    try {
      final String result = await _apiService.beginReceiveDetail(
          data: '|keys:detailId=$id', sessId: token);

      print(result);
      /*final String response =
      TicketDetailsResponseModel.fromJson(jsonDecode(result));*/
      return '';
    } catch (_) {
      logger.e(_.toString());
      return '';
      /*return TicketDetailsResponseModel(
          error: true, message: 'Begin pick ticket detail has an error.');*/
    }
  }

  @override
  Future<String> exitReceiveDetail({String? token, String? id}) async {
    try {
      final String result = await _apiService.exitReceiveDetail(
          data: '|keys:detailId=$id', sessId: token);

      print(result);
      /*final String response =
      TicketDetailsResponseModel.fromJson(jsonDecode(result));*/
      return '';
    } catch (_) {
      logger.e(_.toString());
      return '';
      /*return TicketDetailsResponseModel(
          error: true, message: 'Begin pick ticket detail has an error.');*/
    }
  }

  @override
  Future<ReceiveTicketDetailsResponse> submitReceiveDetail(
      {String? token,
      String? id,
      String? containerId,
      String? qtyReceived}) async {
    try {
      final String result = await _apiService.submitReceiveDetail(
          data:
              '|keys:detailId=$id|vals:qtyReceived=$qtyReceived^containerId=$containerId',
          sessId: token);
      /*final TicketDetailsResponseModel response =
      TicketDetailsResponseModel.fromJson(jsonDecode(result));*/
      return ReceiveTicketDetailsResponse();
    } catch (_) {
      return ReceiveTicketDetailsResponse(
          error: true, message: 'Submit receive details has an error.');
      ;
    }
  }

  @override
  Future<String> completeReceiveTicket(
      {String? token, String? ticketId}) async {
    try {
      final String result = await _apiService.completeReceiveTicket(
          data: '|keys:ticketId=$ticketId', sessId: token);

      //final String response = TicketDetailsResponseModel.fromJson(jsonDecode(result));
      return '';
    } catch (_) {
      return '';
      /*return TicketDetailsResponseModel(
          error: true, message: 'Complete pick ticket has an error.');*/
    }
  }
}
