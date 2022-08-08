import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_response.dart';

abstract class ReceiveTicketDetailsRepository {
  Future<ReceiveTicketDetailsResponse> getReceiveTicketDetails(
      {String? token, String? id});

  Future<String> beginReceiveDetail({String? token, String? id});
  Future<String> exitReceiveDetail({String? token, String? id});
  Future<ReceiveTicketDetailsResponse> submitReceiveDetail(
      {String? token, String? id, String? containerId, String? qtyReceived});
  Future<String> completeReceiveTicket({String? token, String? ticketId});
}
