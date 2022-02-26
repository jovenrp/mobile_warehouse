import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/ticket_details_response_model.dart';

abstract class PickTicketDetailsRepository {
  Future<PickTicketsDetailsResponse> fetchPickTicketsDetails(
      {String? token, String? pickTicketId});

  Future<TicketDetailsResponseModel> beginPick(
      {required String pickTicketDetailId, required String sessId});
  Future<TicketDetailsResponseModel> exitPick(
      {required String pickTicketDetailId, required String sessId});
  Future<TicketDetailsResponseModel> completePickTicket(
      {required String pickTicket, required String sessId});
  Future<TicketDetailsResponseModel> exitPickTicket(
      {required String pickTicket, required String sessId});
  Future<TicketDetailsResponseModel> submitPick(
      {required String pickTicketDetailId,
      required String qtyPicked,
      required String sessId});
}
