import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';

abstract class CountTicketSkusRepository {
  Future<CountTicketDetailsReponse> getCountTicketDetailSkus(
      {String? token, String? id});

  Future<CountTicketDetailsReponse> beginCount({String? token, String? id});

  Future<CountTicketDetailsReponse> exitCount({String? token, String? id});
}
