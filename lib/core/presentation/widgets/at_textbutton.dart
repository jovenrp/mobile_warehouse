import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';

class ATTextButton extends StatelessWidget {
  const ATTextButton(
      {Key? key,
      this.buttonText,
      this.buttonTextStyle,
      this.buttonStyle,
      this.onTap, this.isLoading})
      : super(key: key);

  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onTap;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading == false ? onTap ?? () {} : () {},
      style: buttonStyle ??
          ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(AppColors.beachSea),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ))),
      child: Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 3),
          child: isLoading ?? false
              ? const ATLoadingIndicator()
              : Text(
            buttonText ?? '',
            style: buttonTextStyle ??
                const TextStyle(color: AppColors.white),
          )),
    );
  }
}
