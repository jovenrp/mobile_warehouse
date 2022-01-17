import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATLoadingIndicator extends StatelessWidget {
  const ATLoadingIndicator({Key? key, this.height, this.width, this.color})
      : super(key: key);

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 17,
      width: width ?? 17,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.white),
      ),
    );
  }
}
