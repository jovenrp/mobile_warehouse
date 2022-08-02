import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/domain/bloc/application_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/bloc/count_ticket_details_bloc.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/services/count_ticket_details_api_service.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/domain/repositories/count_ticket_details_repository_impl.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/bloc/count_ticket_skus_bloc.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/data/services/count_ticket_skus_api_service.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/domain/repositories/count_ticket_skus_repository_impl.dart';
import 'package:mobile_warehouse/presentation/count_tickets/bloc/count_tickets_bloc.dart';
import 'package:mobile_warehouse/presentation/count_tickets/data/services/count_tickets_api_service.dart';
import 'package:mobile_warehouse/presentation/count_tickets/domain/repositories/count_tickets_repository_impl.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashbordscreeen_bloc.dart';
import 'package:mobile_warehouse/presentation/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:mobile_warehouse/presentation/item_lookup/bloc/item_lookup_bloc.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/services/item_lookup_api_service.dart';
import 'package:mobile_warehouse/presentation/item_lookup/domain/item_lookup_repository_impl.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_bloc.dart';
import 'package:mobile_warehouse/presentation/location_mapper/data/services/location_mapper_api_service.dart';
import 'package:mobile_warehouse/presentation/location_mapper/domain/location_mapper_repository_impl.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_bloc.dart';
import 'package:mobile_warehouse/presentation/login/data/services/login_api_service.dart';
import 'package:mobile_warehouse/presentation/login/domain/repositories/login_repository_impl.dart';
import 'package:mobile_warehouse/presentation/parent_location/bloc/parent_location_bloc.dart';
import 'package:mobile_warehouse/presentation/picktickets/bloc/pick_tickets_bloc.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/services/pick_tickets_api_service.dart';
import 'package:mobile_warehouse/presentation/picktickets/domain/repositories/pick_tickets_repository_impl.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_bloc.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/services/pick_ticket_details_api_service.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/domain/repositories/pick_ticket_details_repository_impl.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/bloc/receive_ticket_details_bloc.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/services/receive_ticket_details_api_service.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/domain/repositories/receive_ticket_details_repository_impl.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/bloc/receive_tickets_bloc.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/services/receive_tickets_api_service.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/domain/repositories/receive_tickets_repository_impl.dart';
import 'package:mobile_warehouse/presentation/settings/bloc/settings_bloc.dart';
import 'package:mobile_warehouse/presentation/sku_details/bloc/sku_details_bloc.dart';
import 'package:mobile_warehouse/presentation/splash/bloc/splashscreen_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/bloc/stock_adjust_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/services/stock_adjust_api_service.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/domain/repositories/stock_adjust_repository_impl.dart';
import 'package:provider/single_child_widget.dart';

class BlocsProvider {
  static List<SingleChildWidget> provide({
    required Dio dio,
    required PersistenceService persistenceService,
    required String apiUrl,
    required ApplicationBloc appBloc,
    required GlobalKey<NavigatorState> navigatorKey,
  }) =>
      <SingleChildWidget>[
        BlocProvider<ApplicationBloc>(
          create: (_) => ApplicationBloc(),
        ),
        BlocProvider<SplashScreenBloc>(
          create: (_) =>
              SplashScreenBloc(persistenceService: persistenceService),
        ),
        BlocProvider<LoginScreenBloc>(
          create: (_) => LoginScreenBloc(
              loginRepository: LoginRepositoryImpl(
                LoginApiService(dio, baseUrl: apiUrl),
              ),
              persistenceService: persistenceService),
        ),
        BlocProvider<ForgotPasswordBloc>(
          create: (_) =>
              ForgotPasswordBloc(persistenceService: persistenceService),
        ),
        BlocProvider<DashboardScreenBloc>(
          create: (_) =>
              DashboardScreenBloc(persistenceService: persistenceService),
        ),
        BlocProvider<SettingsScreenBloc>(
          create: (_) =>
              SettingsScreenBloc(persistenceService: persistenceService),
        ),
        BlocProvider<PickTicketsBloc>(
          create: (_) => PickTicketsBloc(
              pickTicketsRepository: PickTicketsRepositoryImpl(
                  PickTicketsApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<PickTicketDetailsBloc>(
          create: (_) => PickTicketDetailsBloc(
              pickTicketDetailsRepository: PickTicketDetailsRepositoryImpl(
                  PickTicketDetailsApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<SkuDetailsBloc>(
          create: (_) => SkuDetailsBloc(
              pickTicketDetailsRepository: PickTicketDetailsRepositoryImpl(
                  PickTicketDetailsApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<LocationMapperBloc>(
          create: (_) => LocationMapperBloc(
              locationMapperRepository: LocationMapperRepositoryImpl(
                  LocationMapperApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<ParentLocationBloc>(
          create: (_) => ParentLocationBloc(
              locationMapperRepository: LocationMapperRepositoryImpl(
                  LocationMapperApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<CountTicketsBloc>(
          create: (_) => CountTicketsBloc(
              countTicketsRepository: CountTicketsRepositoryImpl(
                  CountTicketsApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<CountTicketDetailsBloc>(
          create: (_) => CountTicketDetailsBloc(
              countTicketDetailsRepository: CountTicketDetailsRepositoryImpl(
                  CountTicketDetailsApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<CountTicketSkusBloc>(
          create: (_) => CountTicketSkusBloc(
              countTicketSkusRepository: CountTicketSkusRepositoryImpl(
                  CountTicketSkusApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<ItemLookupBloc>(
          create: (_) => ItemLookupBloc(
              itemLookupRepository: ItemLookupRepositoryImpl(
                  ItemLookupApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<StockAdjustBloc>(
          create: (_) => StockAdjustBloc(
              stockAdjustRepository: StockAdjustRepositoryImpl(
                  StockAdjustApiService(dio, baseUrl: apiUrl)),
              itemLookupRepository: ItemLookupRepositoryImpl(
                  ItemLookupApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<ReceiveTicketsBloc>(
          create: (_) => ReceiveTicketsBloc(
              receiveTicketsRepository: ReceiveTicketsRepositoryImpl(
                  ReceiveTicketsApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
        BlocProvider<ReceiveTicketDetailsBloc>(
          create: (_) => ReceiveTicketDetailsBloc(
              receiveTicketDetailsRepository:
                  ReceiveTicketDetailsRepositoryImpl(
                      ReceiveTicketDetailsApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
      ];
}
