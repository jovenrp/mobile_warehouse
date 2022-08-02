import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_response.dart';

abstract class ReceiveTicketDetailsRepository {
  Future<ReceiveTicketDetailsResponse> getReceiveTicketDetails(
      {String? token, String? id});

  Future<String> beginReceiveDetail({String? token, String? id});
}
