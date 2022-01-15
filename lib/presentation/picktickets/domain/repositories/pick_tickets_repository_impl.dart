import 'package:mobile_warehouse/application/application.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_model.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/services/pick_tickets_api_service.dart';

import 'pick_tickets_repository.dart';

class PickTicketsRepositoryImpl implements PickTicketsRepository {
  PickTicketsRepositoryImpl(this._apiService);

  final PickTicketsApiService _apiService;

  @override
  Future<List<PickTicketsModel>> fetchPickTickets({String? token}) async {
    try {
      //dynamic result = await _apiService.fetchPickTickets();

      final String result =
          await _apiService.fetchPickTickets(token, headers: 'true');

      print('asd');
      print(result);

      /*PickTicketsModel pickTicketsModel1 = PickTicketsModel(
        status: '1',
        ticketId: '00001',
        location: 'Warehouse',
        lines: '21',
        sku: '00001',
      );
      PickTicketsModel pickTicketsModel2 = PickTicketsModel(
        status: '2',
        ticketId: '00002',
        location: 'Fritz House',
        lines: '33',
        sku: '00001',
      );
      PickTicketsModel pickTicketsModel3 = PickTicketsModel(
        status: '3',
        ticketId: '00003',
        location: 'Mike House',
        lines: '345',
        sku: '00001',
      );
      List<PickTicketsModel> pickTicketsModel = [
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
        pickTicketsModel1,
        pickTicketsModel2,
        pickTicketsModel3,
      ];*/

      return <PickTicketsModel>[];
    } catch (_) {
      logger.e(_.toString());
      return <PickTicketsModel>[];
    }
  }
}
