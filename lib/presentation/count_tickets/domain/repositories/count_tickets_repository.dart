import 'package:mobile_warehouse/presentation/count_tickets/data/models/count_tickets_response.dart';

abstract class CountTicketsRepository {
  Future<CountTicketsReponse> getCountTickets({String? token});
}
