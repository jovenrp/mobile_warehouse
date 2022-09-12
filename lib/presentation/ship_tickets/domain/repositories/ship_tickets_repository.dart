import 'package:mobile_warehouse/presentation/ship_tickets/data/models/ship_tickets_response.dart';

abstract class ShipTicketsRepository {
  Future<ShipTicketsResponse> getShipTickets({String? token});
}
