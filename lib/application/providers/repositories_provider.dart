import 'package:dio/dio.dart';
import 'package:mobile_warehouse/core/data/services/api_services/actiontrak_api_service.dart';
import 'package:provider/single_child_widget.dart';

class RepositoriesProvider {
  static List<SingleChildWidget> provide({
    required Dio dio,
    required String apiUrl,
    required ActionTRAKApiService actionTRAKApiService,
  }) =>
      <SingleChildWidget>[
        /*Provider<SplashRepository>.value(
          value: SplashRepositoryImpl(
            SplashApiService(dio, baseUrl: apiUrl),
          ),
        ),*/
      ];
}
