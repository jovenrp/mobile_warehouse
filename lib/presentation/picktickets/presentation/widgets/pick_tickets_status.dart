import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class PickTicketsStatusWidget extends StatelessWidget {
  const PickTicketsStatusWidget({Key? key, this.status}) : super(key: key);

  final String? status;
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
          child: SizedBox(width: 7, height: 7),
        );
      case 'processing':
        return Container(
          decoration: BoxDecoration(
              color: AppColors.atYellow,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: AppColors.atYellow)),
          child: SizedBox(width: 7, height: 7),
        );
      case 'processed':
        return Icon(Icons.check_circle,
            color: AppColors.successGreen, size: 12);
      default:
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: AppColors.grey)),
          child: SizedBox(width: 7, height: 7),
        );
    }
  }
}
