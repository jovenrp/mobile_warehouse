import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/application/domain/models/application_config.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/presentation/settings/bloc/settings_bloc.dart';
import 'package:mobile_warehouse/presentation/settings/bloc/settings_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/splash/presentation/splash_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, this.config}) : super(key: key);

  static const String routeName = '/settings';
  static const String screenName = 'settingsScreen';

  final ApplicationConfig? config;

  static ModalRoute<SettingsScreen> route({ApplicationConfig? config}) =>
      MaterialPageRoute<SettingsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => SettingsScreen(config: config),
      );

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  bool pickLimitSetting = false;
  bool isEditApi = false;

  @override
  void initState() {
    super.initState();
    context.read<SettingsScreenBloc>().checkSettings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsScreenBloc, SettingsScreenState>(
        listener: (BuildContext context, SettingsScreenState state) {
      if (!state.isLoading) {
        pickLimitSetting = state.pickLimitSetting ?? false;
      }

      print(state.isSignedOut);
      if (state.isSignedOut == true) {
        Navigator.of(context).pushReplacement(
          SplashScreen.route(config: widget.config),
        );
      }
    }, builder: (BuildContext context, SettingsScreenState state) {
      return SafeArea(
          child: Scaffold(
        appBar: ATAppBar(
          title: I18n.of(context).settings.capitalizeFirstofEach(),
          icon:
              Icon(Icons.arrow_back_sharp, color: AppColors.white, size: 24.0),
          onTap: () => Navigator.of(context).pop(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  child: ATText(
                    text: 'Overrides',
                    fontSize: 16,
                    fontColor: AppColors.greyText,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 8),
                        child: ATText(
                          text: 'Exceed pick limit',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: CupertinoSwitch(
                            value: pickLimitSetting,
                            onChanged: (bool value) {
                              setState(() {
                                pickLimitSetting = !pickLimitSetting;
                                context
                                    .read<SettingsScreenBloc>()
                                    .togglePickLimitSetting(pickLimitSetting);
                              });
                            }),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Container(
                  child: ATText(
                    text: 'User',
                    fontSize: 16,
                    fontColor: AppColors.greyText,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Ink(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.graySeven,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 8),
                              child: ATText(
                                text: 'Change password',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 3),
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: AppColors.greyText,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //about section
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Container(
                  child: ATText(
                    text: 'About',
                    fontSize: 16,
                    fontColor: AppColors.greyText,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.graySeven,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 8),
                          child: ATText(
                            text: 'Version',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 8),
                          alignment: Alignment.centerRight,
                          child: ATText(
                            text: state.appVersion,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.warning_amber_rounded,
                                                  color:
                                                      AppColors.warningOrange,
                                                  size: 50,
                                                ),
                                                SizedBox(height: 10),
                                                ATText(
                                                  text:
                                                      'Server will be changed.',
                                                  fontSize: 16,
                                                  weight: FontWeight.bold,
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 20),
                                                ATText(
                                                  text:
                                                      'You will be forced logout for changes to take effect.',
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
                                                        context
                                                            .read<
                                                                SettingsScreenBloc>()
                                                            .updateApi(api)
                                                            .then((bool
                                                                isUpdated) {
                                                          Navigator.of(
                                                                  dialogContext)
                                                              .pop();
                                                          SnackBar snackBar =
                                                              SnackBar(
                                                            content:
                                                                WillPopScope(
                                                              onWillPop:
                                                                  () async {
                                                                return false;
                                                              },
                                                              child: ATText(
                                                                text:
                                                                    'URL is changed. Re-login is required and App needs to restart.',
                                                                fontColor:
                                                                    AppColors
                                                                        .white,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                seconds: 2),
                                                          );
                                                          setState(() {
                                                            isEditApi = false;
                                                            if (isUpdated) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar)
                                                                  .closed
                                                                  .then((_) {
                                                                context
                                                                    .read<
                                                                        SettingsScreenBloc>()
                                                                    .logout();
                                                              });
                                                            }
                                                          });
                                                        });
                                                      }),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  child: ATTextButton(
                                                    buttonStyle: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(AppColors
                                                                    .white),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          side: BorderSide(
                                                              color: AppColors
                                                                  .beachSea),
                                                        ))),
                                                    buttonTextStyle: TextStyle(
                                                        color:
                                                            AppColors.beachSea),
                                                    isLoading: false,
                                                    buttonText:
                                                        I18n.of(context).cancel,
                                                    onTap: () => Navigator.of(
                                                            dialogContext)
                                                        .pop(),
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
                        : Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: AppColors.graySeven,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 8),
                                    child: ATText(
                                      text: 'URL',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 8),
                                    alignment: Alignment.centerRight,
                                    child: ATText(
                                      text: state.url,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
              ],
            ),
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
