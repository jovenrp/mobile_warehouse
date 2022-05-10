import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/domain/bloc/application_bloc.dart';
import 'package:mobile_warehouse/core/data/services/persistence_service.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashbordscreeen_bloc.dart';
import 'package:mobile_warehouse/presentation/forgot_password/bloc/forgot_password_bloc.dart';
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
import 'package:mobile_warehouse/presentation/settings/bloc/settings_bloc.dart';
import 'package:mobile_warehouse/presentation/sku_details/bloc/sku_details_bloc.dart';
import 'package:mobile_warehouse/presentation/splash/bloc/splashscreen_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_count/bloc/stock_count_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_count/data/services/stock_counts_api_service.dart';
import 'package:mobile_warehouse/presentation/stock_count/domain/repositories/stock_count_repository_impl.dart';
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
        BlocProvider<StockCountBloc>(
          create: (_) => StockCountBloc(
              stockCountRepository: StockCountRepositoryImpl(
                  StockCountApiService(dio, baseUrl: apiUrl)),
              persistenceService: persistenceService),
        ),
      ];
}
