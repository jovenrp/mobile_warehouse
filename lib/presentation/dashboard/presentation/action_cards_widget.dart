import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';

class ActionCardsWidget extends StatelessWidget {
  const ActionCardsWidget({Key? key, this.title, this.description})
      : super(key: key);

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            AppColors.semiDark,
            AppColors.beachSea,
          ],
        ),
        border: Border.all(
          color: AppColors.beachSea,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ATText(text: title, fontSize: 14, fontColor: AppColors.white),
              Icon(
                // Based on passwordVisible state choose the icon
                Icons.double_arrow_outlined,
                color: AppColors.white,
              ),
            ],
          ),
          Divider(color: AppColors.atDark),
          ATText(text: description, fontSize: 14, fontColor: AppColors.white),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
