import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATLoadingIndicator extends StatelessWidget {
  const ATLoadingIndicator({Key? key, this.height, this.width})
      : super(key: key);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 17,
      width: width ?? 17,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
      ),
    );
  }
}
