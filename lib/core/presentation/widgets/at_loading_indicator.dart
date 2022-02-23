import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATLoadingIndicator extends StatelessWidget {
  const ATLoadingIndicator(
      {Key? key, this.height, this.width, this.color, this.strokeWidth})
      : super(key: key);

  final double? height;
  final double? width;
  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 17,
      width: width ?? 17,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 4.0,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.white),
      ),
    );
  }
}
