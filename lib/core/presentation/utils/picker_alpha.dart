import 'package:flutter/cupertino.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';

class PickerAlpha extends StatelessWidget {
  const PickerAlpha({Key? key, required this.index, this.isAlphabet}) : super(key: key);

  final String index;
  final bool? isAlphabet;

  @override
  Widget build(BuildContext context) {
    return ATText(
      text: isAlphabet == true ? '$index' : (int.parse(index) + 1) < 10 ? '0${int.parse(index) + 1}' : '${int.parse(index) + 1}',
      fontColor: AppColors.white,
      fontSize: 24,
      weight: FontWeight.bold,
    );
  }
}
