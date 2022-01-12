import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashboardscreen_state.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashbordscreeen_bloc.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/login/presentation/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const String routeName = '/dashboard';
  static const String screenName = 'dashboardScreen';

  static ModalRoute<DashboardScreen> route() =>
      MaterialPageRoute<DashboardScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const DashboardScreen(),
      );

  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardScreenBloc, DashboardScreenState>(
        listener: (BuildContext context, DashboardScreenState state) {},
        builder: (BuildContext context, DashboardScreenState state) {
          return SafeArea(
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
                            return Dialog(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * .15,
                                width: MediaQuery.of(context).size.width * .2,
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ATText(text:'Logout from Mobile Warehouse?'),

                                      Expanded(
                                          child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * .3,
                                            child: ATTextButton(buttonText: 'Yes, Logout', onTap: () => Navigator.of(context).pushReplacement(
                                              LoginScreen.route(),
                                            )),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * .3,
                                            child: ATTextButton(buttonText: 'No, Go back', buttonTextStyle: TextStyle(color: AppColors.beachSea), buttonStyle: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(AppColors.white)), onTap: () => Navigator.pop(context)),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                      ))));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
