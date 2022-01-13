import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/data/mixin/back_pressed_mixin.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/application_logo.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/dashboard/presentation/dashboard_screen.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_bloc.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';
  static const String screenName = 'loginScreen';

  static ModalRoute<LoginScreen> route() => MaterialPageRoute<LoginScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const LoginScreen(),
      );

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> with BackPressedMixin {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
        listener: (BuildContext context, LoginScreenState state) {
      if (!state.isLoading) {
        if (!state.hasError) {
          Navigator.of(context).pushReplacement(
              DashboardScreen.route(userProfileModel: state.userProfileModel));
        }
      }
    }, builder: (BuildContext context, LoginScreenState state) {
      return SafeArea(
          child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                        ),
                        const ApplicationLogo(),
                        ATTextfield(
                          hintText: I18n.of(context).enter_username,
                          textEditingController: usernameController,
                        ),
                        const SizedBox(height: 8),
                        ATTextfield(
                          hintText: I18n.of(context).enter_password,
                          textEditingController: passwordController,
                          isPasswordField: true,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            state.hasError
                                ? ATText(
                                    text:
                                        state.loginResponseModel?.errorMessage,
                                    fontColor: AppColors.atRed,
                                    fontSize: 12,
                                  )
                                : SizedBox(),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () => context
                                  .read<LoginScreenBloc>()
                                  .forgotPassword(),
                              child: ATText(
                                text: I18n.of(context).forgot_password,
                                fontColor: AppColors.beachSea,
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: ATTextButton(
                    buttonText: I18n.of(context).sign_in,
                    onTap: () {
                      context.read<LoginScreenBloc>().login(
                          usernameController.text, passwordController.text);
                    },
                  ),
                ),
              )));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
