import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_response.dart';

abstract class CountTicketDetailsRepository {
  Future<CountTicketDetailsReponse> getCountTicketDetails(
      {String? token, String? id});
}
