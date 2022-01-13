import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/mixin/back_pressed_mixin.dart';
import 'package:mobile_warehouse/core/domain/models/user_profile_model.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_dialog.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashboardscreen_state.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashbordscreeen_bloc.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/dashboard/presentation/localtion_mapper_widget.dart';
import 'package:mobile_warehouse/presentation/login/presentation/login_screen.dart';
import 'package:mobile_warehouse/presentation/picktickets/presentation/pick_tickets_screen.dart';

import 'action_cards_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, this.userProfileModel}) : super(key: key);

  static const String routeName = '/dashboard';
  static const String screenName = 'dashboardScreen';

  final UserProfileModel? userProfileModel;

  static ModalRoute<DashboardScreen> route(
          {UserProfileModel? userProfileModel}) =>
      MaterialPageRoute<DashboardScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => DashboardScreen(userProfileModel: userProfileModel),
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
    SnackBar snackBar = SnackBar(
      content: ATText(
        text: 'No function implementation yet!',
        fontColor: AppColors.white,
      ),
      duration: Duration(seconds: 1),
    );
    return BlocConsumer<DashboardScreenBloc, DashboardScreenState>(
        listener: (BuildContext context, DashboardScreenState state) {
      if (state.isSignedOut) {
        Navigator.of(context).pushReplacement(
          LoginScreen.route(),
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
                      color: Colors.black,
                      size: 24.0,
                    ),
                    rotation: 2,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ATDialog(
                              bodyMessage:
                                  I18n.of(context).logout_from_mobile_warehouse,
                              positiveActionText: I18n.of(context).yes_logout,
                              negativeActionText: I18n.of(context).no_go_back,
                              positiveAction: () =>
                                  context.read<DashboardScreenBloc>().logout(),
                            );
                          });
                    },
                  ),
                  body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: ATText(
                              text: I18n.of(context)
                                  .hi_name(widget.userProfileModel?.username),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              LocationMapperWidget(
                                  onTap: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar)),
                            ],
                          ),
                          SizedBox(height: 40),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ActionCardsWidget(
                                  title: I18n.of(context).count_list,
                                  description:
                                      I18n.of(context).count_list_description,
                                )),
                          ),
                          SizedBox(height: 14),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ActionCardsWidget(
                                  title: I18n.of(context).stock_count,
                                  description:
                                      I18n.of(context).stock_count_description,
                                )),
                          ),
                          SizedBox(height: 14),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .push(PickTicketsScreen.route()),
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ActionCardsWidget(
                                  title: I18n.of(context).pick_tickets,
                                  description: I18n.of(context)
                                      .pick_ticketst_description,
                                )),
                          )
                        ],
                      )))));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
