import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';

abstract class PickTicketDetailsRepository {
  Future<PickTicketsDetailsResponse> fetchPickTicketsDetails(
      {String? token, String? pickTicketId});
}
