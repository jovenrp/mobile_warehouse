import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_response.dart';

abstract class PickTicketsRepository {
  Future<PickTicketsResponse> fetchPickTickets({String? token});
}
