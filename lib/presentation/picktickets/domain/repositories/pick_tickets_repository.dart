import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_response.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_ticket_details_response.dart';

abstract class PickTicketsRepository {
  Future<PickTicketsResponse> fetchPickTickets({String? token});
}
