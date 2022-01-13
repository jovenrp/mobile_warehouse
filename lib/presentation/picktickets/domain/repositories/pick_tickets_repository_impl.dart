import 'package:mobile_warehouse/presentation/picktickets/data/services/pick_tickets_api_service.dart';

import 'pick_tickets_repository.dart';

class PickTicketsRepositoryImpl implements PickTicketsRepository {
  PickTicketsRepositoryImpl(this._apiService);

  final PickTicketsApiService _apiService;

  @override
  Future<String> fetchPickTickets({String? token}) async {
    try {
      //dynamic result = await _apiService.fetchPickTickets();

      final dynamic result = await _apiService.fetchPickTickets(token);

      //final Map<String, dynamic>? data = result.response?.data;

      print(result);
      return '1';
    } catch (_) {
      print(_.toString());
      return '22';
    }
  }
}
