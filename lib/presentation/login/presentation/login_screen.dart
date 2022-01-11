import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/presentation/widgets/application_logo.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
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

class _LoginScreen extends State<LoginScreen> {
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
        listener: (BuildContext context, LoginScreenState state) {},
        builder: (BuildContext context, LoginScreenState state) {
          return SafeArea(
              child: Scaffold(
            body: Padding(
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
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: ATTextButton(
                buttonText: I18n.of(context).sign_in,
                onTap: () {
                  context
                      .read<LoginScreenBloc>()
                      .login(usernameController.text, passwordController.text);
                },
              ),
            ),
          ));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
