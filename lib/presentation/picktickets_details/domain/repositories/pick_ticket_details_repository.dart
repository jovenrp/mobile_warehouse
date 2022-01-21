import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';

abstract class PickTicketDetailsRepository {
  Future<PickTicketsDetailsResponse> fetchPickTicketsDetails(
      {String? token, String? pickTicketId});

  Future<PickTicketsDetailsResponse> updateTicketDetails(
      {List<PickTicketDetailsModel>? pickTicketDetailsModel});
}
