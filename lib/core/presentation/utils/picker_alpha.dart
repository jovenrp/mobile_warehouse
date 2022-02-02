import 'package:flutter/cupertino.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';

class PickerAlpha extends StatelessWidget {
  const PickerAlpha({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ATText(
      text: index < 10 ? '0${index + 1}' : '${index + 1}',
      fontColor: AppColors.white,
      fontSize: 24,
      weight: FontWeight.bold,
    );
  }
}
