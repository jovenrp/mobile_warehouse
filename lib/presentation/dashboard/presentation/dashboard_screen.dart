import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/domain/models/application_config.dart';
import 'package:mobile_warehouse/core/data/mixin/back_pressed_mixin.dart';
import 'package:mobile_warehouse/core/domain/models/user_profile_model.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_dialog.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/count_tickets/presentation/count_tickets_screen.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashboardscreen_state.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashbordscreeen_bloc.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/presentation/item_lookup/presentation/item_lookup_screen.dart';
import 'package:mobile_warehouse/presentation/login/presentation/login_screen.dart';
import 'package:mobile_warehouse/presentation/parent_location/presentation/parent_location_screen.dart';
import 'package:mobile_warehouse/presentation/picktickets/presentation/pick_tickets_screen.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/presentation/receive_tickets_screen.dart';
import 'package:mobile_warehouse/presentation/settings/presentation/settings_screen.dart';
import 'package:mobile_warehouse/presentation/stock_actions/presentation/stock_actions_screen.dart';

import 'action_cards_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen(
      {Key? key, this.userProfileModel, this.config, this.username})
      : super(key: key);

  static const String routeName = '/dashboard';
  static const String screenName = 'dashboardScreen';

  final UserProfileModel? userProfileModel;
  final ApplicationConfig? config;
  final String? username;

  static ModalRoute<DashboardScreen> route(
          {UserProfileModel? userProfileModel,
          ApplicationConfig? config,
          String? username}) =>
      MaterialPageRoute<DashboardScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => DashboardScreen(
            userProfileModel: userProfileModel,
            config: config,
            username: username),
      );

  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> with BackPressedMixin {
  bool _isDoubleBackPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*SnackBar snackBar = SnackBar(
      content: ATText(
        text: 'No function implementation yet!',
        fontColor: AppColors.white,
      ),
      duration: Duration(seconds: 1),
    );*/
    return BlocConsumer<DashboardScreenBloc, DashboardScreenState>(
        listener: (BuildContext context, DashboardScreenState state) {
      if (state.isSignedOut) {
        Navigator.of(context).pushReplacement(
          LoginScreen.route(config: widget.config),
        );
      }
    }, builder: (BuildContext context, DashboardScreenState state) {
      return SafeArea(
          child: WillPopScope(
              onWillPop: () async {
                if (Platform.isAndroid) {
                  _isDoubleBackPressed = onBackPressed(
                      context, _isDoubleBackPressed, (bool value) {
                    _isDoubleBackPressed = value;
                    print(_isDoubleBackPressed);
                  });
                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                appBar: ATAppBar(
                  title: I18n.of(context).dashboard,
                  icon: Icon(
                    Icons.logout,
                    color: AppColors.white,
                    size: 24.0,
                  ),
                  rotation: 2,
                  actions: <Widget>[
                    Ink(
                      child: InkWell(
                        onTap: () => Navigator.of(context)
                            .push(SettingsScreen.route(config: widget.config)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Icon(
                            Icons.settings,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ATDialog(
                            isLoading: state.isLoading,
                            bodyMessage:
                                I18n.of(context).logout_from_mobile_warehouse,
                            positiveActionText: I18n.of(context).yes_logout,
                            negativeActionText: I18n.of(context).no_go_back,
                            positiveAction: () =>
                                context.read<DashboardScreenBloc>().logout(),
                            negativeAction: () => Navigator.of(context).pop(),
                          );
                        });
                  },
                ),
                body: Stack(children: <Widget>[
                  Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppColors.beachSea,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 18, top: 20),
                        child: ATText(
                          text: I18n.of(context).hi_name(
                              widget.userProfileModel?.username ??
                                  widget.username),
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 15),
                            child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(PickTicketsScreen.route()),
                                    child: ActionCardsWidget(
                                      title: 'Pick',
                                      description: I18n.of(context)
                                          .pick_ticketst_description,
                                      icon: Icon(Icons.note,
                                          color: AppColors.white, size: 70),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(ReceiveTicketsScreen.route()),
                                    child: ActionCardsWidget(
                                      title: 'Receive',
                                      description: '',
                                      icon: Icon(Icons.call_received,
                                          color: AppColors.white, size: 70),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        ParentLocationScreen.route(
                                            parentId: 'Root',
                                            navigation: 'pop')),
                                    child: ActionCardsWidget(
                                      title: I18n.of(context)
                                          .location_mapper
                                          .capitalizeFirstofEach(),
                                      description: I18n.of(context)
                                          .pick_ticketst_description,
                                      icon: Icon(Icons.edit_location_outlined,
                                          color: AppColors.white, size: 70),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(CountTicketsScreen.route()),
                                    child: ActionCardsWidget(
                                      title: I18n.of(context)
                                          .stock_count
                                          .capitalizeFirstofEach(),
                                      description: I18n.of(context)
                                          .stock_count_description,
                                      icon: Icon(Icons.move_to_inbox,
                                          color: AppColors.white, size: 70),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(ItemLookupScreen.route()),
                                    child: ActionCardsWidget(
                                      title: 'Item Lookup',
                                      description: 'Item lookup description',
                                      icon: Icon(Icons.youtube_searched_for,
                                          color: AppColors.white, size: 70),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(StockActionsScreen.route()),
                                    child: ActionCardsWidget(
                                      title: 'Stock Actions',
                                      description: 'Stock Actions',
                                      icon: Icon(Icons.adjust,
                                          color: AppColors.white, size: 70),
                                    ),
                                  ),
                                ])),
                      )
                    ],
                  )
                ]),
              )));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
