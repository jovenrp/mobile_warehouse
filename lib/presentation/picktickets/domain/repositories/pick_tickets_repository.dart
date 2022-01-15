import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_model.dart';

abstract class PickTicketsRepository {
  Future<List<PickTicketsModel>> fetchPickTickets({String? token});
}
