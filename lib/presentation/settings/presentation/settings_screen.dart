import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/presentation/settings/bloc/settings_bloc.dart';
import 'package:mobile_warehouse/presentation/settings/bloc/settings_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const String routeName = '/settings';
  static const String screenName = 'settingsScreen';

  static ModalRoute<SettingsScreen> route() =>
      MaterialPageRoute<SettingsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => SettingsScreen(),
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
                            onFieldSubmitted: (String? api) {
                              if (api?.isNotEmpty == true) {
                                context
                                    .read<SettingsScreenBloc>()
                                    .updateApi(api)
                                    .then((bool isUpdated) {
                                  SnackBar snackBar = SnackBar(
                                    content: ATText(
                                      text:
                                          'URL is changed. Re-login is required and App needs to restart.',
                                      fontColor: AppColors.white,
                                    ),
                                    duration: Duration(seconds: 5),
                                  );
                                  setState(() {
                                    isEditApi = false;
                                    if (isUpdated) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  });
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
