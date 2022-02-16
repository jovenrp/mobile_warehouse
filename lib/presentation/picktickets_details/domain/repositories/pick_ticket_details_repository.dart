import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';

abstract class PickTicketDetailsRepository {
  Future<PickTicketsDetailsResponse> fetchPickTicketsDetails(
      {String? token, String? pickTicketId});

  Future<String> beginPick(
      {required String pickTicketDetailId, required String sessId});
  Future<String> exitPick(
      {required String pickTicketDetailId, required String sessId});
  Future<String> completePickTicket(
      {required String pickTicket, required String sessId});
  Future<String> exitPickTicket(
      {required String pickTicket, required String sessId});
  Future<String> submitPick(
      {required String pickTicketDetailId,
      required String qtyPicked,
      required String sessId});
}
