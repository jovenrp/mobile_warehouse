import 'package:mobile_warehouse/presentation/pack_tickets/data/models/pack_tickets_response.dart';

abstract class PackTicketsRepository {
  Future<PackTicketsResponse> getPackTickets({String? token});
}
