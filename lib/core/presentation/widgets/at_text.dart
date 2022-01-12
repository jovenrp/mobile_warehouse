import 'package:flutter/cupertino.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATText extends StatelessWidget {
  const ATText({Key? key, this.text, this.fontColor, this.fontSize, this.style})
      : super(key: key);

  final String? text;
  final Color? fontColor;
  final double? fontSize;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(text ?? '',
        style: style ??
            TextStyle(
                color: fontColor ?? AppColors.black, fontSize: fontSize ?? 14));
  }
}
