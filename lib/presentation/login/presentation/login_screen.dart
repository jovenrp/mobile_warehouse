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

  static ModalRoute<LoginScreen> route({ApplicationConfig? config}) =>
      MaterialPageRoute<LoginScreen>(
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
  bool isEditApi = false;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    context.read<LoginScreenBloc>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
        listener: (BuildContext context, LoginScreenState state) {
      if (!state.isLoading) {
        if (state.isLoggedIn) {
          Navigator.of(context).pushReplacement(DashboardScreen.route(
              userProfileModel: state.userProfileModel,
              config: widget.config,
              username: usernameController.text));
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
                            InkWell(
                              onTap: () => Navigator.of(context)
                                  .push(ForgotPasswordScreen.route()),
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
                              context.read<LoginScreenBloc>().login(
                                  usernameController.text,
                                  passwordController.text);
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .2,
                        ),
                        ATText(
                          text: 'v${widget.config?.appVersion}',
                          fontColor: AppColors.greyRed,
                          fontSize: 12,
                        ),
                        GestureDetector(
                            onHorizontalDragEnd: (DragEndDetails details) {
                              if (details.primaryVelocity != 0) {
                                setState(() {
                                  setState(() {
                                    if (!isEditApi) {
                                      isEditApi = true;
                                    }
                                  });
                                });
                              }
                            },
                            child: isEditApi
                                ? ATTextfield(
                                    hintText: state.url,
                                    onFieldSubmitted: (String? api) async {
                                      if (api?.isNotEmpty == true) {
                                        await showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return Dialog(
                                                child: SizedBox(
                                                  height: 320,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons
                                                              .warning_amber_rounded,
                                                          color: AppColors
                                                              .warningOrange,
                                                          size: 50,
                                                        ),
                                                        SizedBox(height: 10),
                                                        ATText(
                                                          text:
                                                              'Server will be changed.',
                                                          fontSize: 16,
                                                          weight:
                                                              FontWeight.bold,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(height: 20),
                                                        ATText(
                                                          text:
                                                              'App needs to restart for changes to take effect.',
                                                          fontSize: 16,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(height: 30),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: ATTextButton(
                                                              isLoading: false,
                                                              buttonText:
                                                                  'Save',
                                                              onTap: () {
                                                                context
                                                                    .read<
                                                                        LoginScreenBloc>()
                                                                    .updateApi(
                                                                        api)
                                                                    .then((bool
                                                                        isUpdated) {
                                                                  Navigator.of(
                                                                          dialogContext)
                                                                      .pop();
                                                                  SnackBar
                                                                      snackBar =
                                                                      SnackBar(
                                                                    content:
                                                                        WillPopScope(
                                                                      onWillPop:
                                                                          () async {
                                                                        return false;
                                                                      },
                                                                      child:
                                                                          ATText(
                                                                        text:
                                                                            'URL is changed. App needs to restart for changes to take effect.',
                                                                        fontColor:
                                                                            AppColors.white,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        seconds:
                                                                            2),
                                                                  );
                                                                  setState(() {
                                                                    isEditApi =
                                                                        false;
                                                                    if (isUpdated) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .hideCurrentSnackBar();
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              snackBar);
                                                                    }
                                                                  });
                                                                });
                                                              }),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: ATTextButton(
                                                            buttonStyle:
                                                                ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(AppColors
                                                                            .white),
                                                                    shape: MaterialStateProperty.all<
                                                                            RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      side: BorderSide(
                                                                          color:
                                                                              AppColors.beachSea),
                                                                    ))),
                                                            buttonTextStyle: TextStyle(
                                                                color: AppColors
                                                                    .beachSea),
                                                            isLoading: false,
                                                            buttonText:
                                                                I18n.of(context)
                                                                    .cancel,
                                                            onTap: () =>
                                                                Navigator.of(
                                                                        dialogContext)
                                                                    .pop(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      } else {
                                        setState(() {
                                          isEditApi = false;
                                        });
                                      }
                                    },
                                  )
                                : Visibility(
                                    visible:
                                        widget.config?.isApiDebuggerEnabled ??
                                            false,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ATText(
                                        text: '${state.apiUrl}',
                                        fontColor: AppColors.greyRed,
                                        fontSize: 12,
                                      ),
                                    ))),
                        SizedBox(height: 50)
                      ],
                    ),
                  ),
                ),
                /*bottomNavigationBar: Padding(
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
                            fontSize: 12,
                          ),
                          Slidable(
                              key: ValueKey<int>(0),
                              startActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),
                                  children: <Widget>[
                                    SlidableAction(
                                      onPressed: (BuildContext context) => setState(() {
                                        setState(() {
                                          if (!isEditApi) {
                                            isEditApi = true;
                                          }
                                        });
                                      }),
                                      backgroundColor: AppColors.atLightBlue,
                                      foregroundColor: AppColors.white,
                                      icon: Icons.edit,
                                    ),
                                  ]),
                              child: isEditApi
                                  ? ATTextfield(
                                      hintText: state.url,
                                      onFieldSubmitted: (String? api) async {
                                        if (api?.isNotEmpty == true) {
                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext dialogContext) {
                                                return Dialog(
                                                  child: SizedBox(
                                                    height: 320,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(14),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.warning_amber_rounded,
                                                            color: AppColors.warningOrange,
                                                            size: 50,
                                                          ),
                                                          SizedBox(height: 10),
                                                          ATText(
                                                            text: 'Server will be changed.',
                                                            fontSize: 16,
                                                            weight: FontWeight.bold,
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          SizedBox(height: 20),
                                                          ATText(
                                                            text: 'App needs to restart for changes to take effect.',
                                                            fontSize: 16,
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          SizedBox(height: 30),
                                                          Container(
                                                            width: double.infinity,
                                                            child: ATTextButton(
                                                                isLoading: false,
                                                                buttonText: 'Save',
                                                                onTap: () {
                                                                  context.read<LoginScreenBloc>().updateApi(api).then((bool isUpdated) {
                                                                    Navigator.of(dialogContext).pop();
                                                                    SnackBar snackBar = SnackBar(
                                                                      content: WillPopScope(
                                                                        onWillPop: () async {
                                                                          return false;
                                                                        },
                                                                        child: ATText(
                                                                          text: 'URL is changed. App needs to restart for changes to take effect.',
                                                                          fontColor: AppColors.white,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(seconds: 2),
                                                                    );
                                                                    setState(() {
                                                                      isEditApi = false;
                                                                      if (isUpdated) {
                                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                      }
                                                                    });
                                                                  });
                                                                }),
                                                          ),
                                                          Container(
                                                            width: double.infinity,
                                                            child: ATTextButton(
                                                              buttonStyle: ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    side: BorderSide(color: AppColors.beachSea),
                                                                  ))),
                                                              buttonTextStyle: TextStyle(color: AppColors.beachSea),
                                                              isLoading: false,
                                                              buttonText: I18n.of(context).cancel,
                                                              onTap: () => Navigator.of(dialogContext).pop(),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        } else {
                                          setState(() {
                                            isEditApi = false;
                                          });
                                        }
                                      },
                                    )
                                  : Visibility(
                                      visible: widget.config?.isApiDebuggerEnabled ?? false,
                                      child: ATText(
                                        text: '${state.apiUrl}',
                                        fontColor: AppColors.greyRed,
                                        fontSize: 12,
                                      )))
                        ],
                      )
                    ],
                  ),
                ),*/
              )));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
