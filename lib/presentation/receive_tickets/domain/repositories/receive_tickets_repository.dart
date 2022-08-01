import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_response.dart';

abstract class ReceiveTicketsRepository {
  Future<ReceiveTicketsResponse> getReceiveTickets({String? token});
}
