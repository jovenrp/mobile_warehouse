import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/domain/models/application_config.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/application_logo.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/company_name.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/dashboard/presentation/dashboard_screen.dart';
import 'package:mobile_warehouse/presentation/login/presentation/login_screen.dart';
import 'package:mobile_warehouse/presentation/splash/bloc/splashscreen_bloc.dart';
import 'package:mobile_warehouse/presentation/splash/bloc/splashscreen_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key, this.config}) : super(key: key);

  static const String routeName = '/splash';
  static const String screenName = 'splashScreen';

  final ApplicationConfig? config;

  static ModalRoute<SplashScreen> route({ApplicationConfig? config}) =>
      MaterialPageRoute<SplashScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => SplashScreen(config: config),
      );

  @override
  Widget build(BuildContext context) {
    context.read<SplashScreenBloc>().loadSplashScreen(config: config);
    return BlocConsumer<SplashScreenBloc, SplashScreenState>(
        listener: (BuildContext context, SplashScreenState state) {
      if (!state.isLoading) {
        if (state.isAlreadySignedIn == true) {
          Navigator.of(context).pushReplacement(
            DashboardScreen.route(userProfileModel: state.userProfileModel),
          );
        } else {
          Navigator.of(context).pushReplacement(
            LoginScreen.route(config: config),
          );
        }
      }
    }, builder: (BuildContext context, SplashScreenState state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(I18n.of(context).application_name),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * .2),
            const ApplicationLogo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(I18n.of(context).powered_by,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    )),
                const SizedBox(
                  width: 5,
                ),
                CompanyName(
                  firstname: I18n.of(context).company_firstname,
                  lastname: I18n.of(context).company_lastname,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ATText(
                  text: state.apiUrl,
                  fontSize: 12,
                  fontColor: AppColors.black,
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
