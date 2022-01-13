import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/presentation/login/presentation/login_screen.dart';

import 'at_text.dart';
import 'at_textbutton.dart';

class ATDialog extends StatelessWidget {
  const ATDialog(
      {Key? key,
      this.bodyMessage,
      this.positiveActionText,
      this.positiveAction,
      this.negativeActionText,
      this.negativeAction})
      : super(key: key);

  final String? bodyMessage;
  final String? positiveActionText;
  final VoidCallback? positiveAction;
  final String? negativeActionText;
  final VoidCallback? negativeAction;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .15,
        width: MediaQuery.of(context).size.width * .2,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ATText(text: bodyMessage),
              Expanded(
                  child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: ATTextButton(
                        buttonText: positiveActionText,
                        onTap: positiveAction ??
                            () => Navigator.of(context).pushReplacement(
                                  LoginScreen.route(),
                                )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: ATTextButton(
                        buttonText: negativeActionText,
                        buttonTextStyle: TextStyle(color: AppColors.beachSea),
                        buttonStyle: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.white)),
                        onTap: negativeAction ?? () => Navigator.pop(context)),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
