import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/application/domain/models/application_config.dart';
import 'package:mobile_warehouse/core/data/mixin/back_pressed_mixin.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/application_logo.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/dashboard/presentation/dashboard_screen.dart';
import 'package:mobile_warehouse/presentation/forgot_password/presentation/forgot_password_screen.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_bloc.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_state.dart';

// This class to display the loging page
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.config}) : super(key: key);

  static const String routeName = '/login';
  static const String screenName = 'loginScreen';

  final ApplicationConfig? config;

  static ModalRoute<LoginScreen> route({ApplicationConfig? config}) => MaterialPageRoute<LoginScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => LoginScreen(
          config: config,
        ),
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

    context.read<LoginScreenBloc>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(listener: (BuildContext context, LoginScreenState state) {
      if (!state.isLoading) {
        if (!state.hasError) {
          Navigator.of(context).pushReplacement(DashboardScreen.route(userProfileModel: state.userProfileModel, config: widget.config));
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
                                    text: state.loginResponseModel?.errorMessage,
                                    fontColor: AppColors.atRed,
                                    fontSize: 12,
                                  )
                                : SizedBox(),
                            InkWell(
                              onTap: () => Navigator.of(context).push(ForgotPasswordScreen.route()),
                              child: ATText(
                                text: I18n.of(context).forgot_password,
                                fontColor: AppColors.beachSea,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          child: ATTextButton(
                            isLoading: state.isLoading,
                            buttonText: I18n.of(context).sign_in,
                            onTap: () {
                              context.read<LoginScreenBloc>().login(usernameController.text, passwordController.text);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ATText(
                            text: 'v${widget.config?.appVersion}',
                            fontColor: AppColors.greyRed,
                          ),
                          Visibility(
                              visible: widget.config?.isApiDebuggerEnabled ?? false,
                              child: ATText(
                                text: '${widget.config?.apiUrl}',
                                fontColor: AppColors.greyRed,
                              ))
                        ],
                      )
                    ],
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
