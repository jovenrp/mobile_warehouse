import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';

class PickTicketsStatusWidget extends StatelessWidget {
  const PickTicketsStatusWidget({Key? key, this.status, this.turns})
      : super(key: key);

  final String? status;
  final int? turns;

  @override
  Widget build(BuildContext context) {
    switch (status?.toLowerCase()) {
      case 'picking':
        return Icon(Icons.circle_notifications,
            color: AppColors.warningOrange, size: 12);
      case 'picked':
        return Icon(Icons.arrow_circle_up,
            color: AppColors.bluishPurple, size: 12);
      case 'closed':
        return Icon(Icons.check_circle,
            color: AppColors.successGreen, size: 12);
      case 'partial':
        return Container(
          decoration: BoxDecoration(
              color: AppColors.warningOrange,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: AppColors.warningOrange)),
          child: SizedBox(
            width: 10,
            height: 10,
            child: Container(
              alignment: Alignment.center,
              child: ATText(text: '!', fontSize: 8, fontColor: AppColors.white),
            ),
          ),
        );
      case 'processing':
        return Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: AppColors.atDarkYellow)),
          child: RotatedBox(
            quarterTurns: turns ?? 0,
            child: SizedBox(
              width: 10,
              height: 10,
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.hourglass_bottom,
                  color: AppColors.gomoYellow,
                  size: 10,
                ),
              ),
            ),
          ),
        );
      case 'processed':
        return Container(
          decoration: BoxDecoration(
              color: AppColors.successGreen,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: AppColors.successGreen)),
          child: SizedBox(
            width: 10,
            height: 10,
            child: Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                color: AppColors.white,
                size: 10,
              ),
            ),
          ),
        );
      default:
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: AppColors.grey)),
          child: SizedBox(width: 10, height: 10),
        );
    }
  }
}
