import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/presentation/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:mobile_warehouse/presentation/forgot_password/bloc/forgot_password_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = '/forgotPassword';
  static const String screenName = 'forgotPasswordScreen';

  static ModalRoute<ForgotPasswordScreen> route() =>
      MaterialPageRoute<ForgotPasswordScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const ForgotPasswordScreen(),
      );

  @override
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    context.read<ForgotPasswordBloc>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (BuildContext context, ForgotPasswordState state) {},
        builder: (BuildContext context, ForgotPasswordState state) {
          return SafeArea(
              child: Scaffold(
            appBar: ATAppBar(
              title: I18n.of(context).password_recovery.capitalizeFirstofEach(),
              icon: Icon(Icons.arrow_back_sharp,
                  color: AppColors.white, size: 24.0),
              onTap: () => Navigator.of(context).pop(),
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 100),
                      ATText(
                          text: I18n.of(context).forgot_password_header,
                          weight: FontWeight.bold,
                          fontSize: 42),
                      SizedBox(height: 80),
                      ATText(
                          text: I18n.of(context).forgot_password_description,
                          fontSize: 16),
                      SizedBox(height: 8),
                      ATTextfield(
                        hintText: I18n.of(context).enter_email,
                        textEditingController: emailController,
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: state.hasError,
                        child: ATText(
                          text: state.errorMessage,
                          fontColor: AppColors.atRed,
                          fontSize: 12,
                        ),
                      ),
                      Visibility(
                        visible: state.isSuccess,
                        child: ATText(
                          text: I18n.of(context).email_success_message,
                          fontColor: AppColors.successGreen,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        width: double.infinity,
                        child: ATTextButton(
                          isLoading: state.isLoading,
                          buttonText: I18n.of(context).submit_button,
                          onTap: () {
                            context
                                .read<ForgotPasswordBloc>()
                                .submitEmail(emailController.text);
                          },
                        ),
                      )
                    ],
                  ),
                )),
          ));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
