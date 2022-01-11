import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_bloc.dart';
import 'package:mobile_warehouse/presentation/login/bloc/loginscreen_state.dart';

class ATTextButton extends StatelessWidget {
  const ATTextButton(
      {Key? key,
      this.buttonText,
      this.buttonTextStyle,
      this.buttonStyle,
      this.onTap})
      : super(key: key);

  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
        listener: (BuildContext context, LoginScreenState state) {},
        builder: (BuildContext context, LoginScreenState state) {
          return TextButton(
            onPressed: !state.isLoading ? onTap ?? () {} : () {},
            child: Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 3),
                child: state.isLoading
                    ? const ATLoadingIndicator()
                    : Text(
                        buttonText ?? '',
                        style: buttonTextStyle ??
                            const TextStyle(color: AppColors.white),
                      )),
            style: buttonStyle ??
                ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.beachSea),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ))),
          );
        });
  }
}
