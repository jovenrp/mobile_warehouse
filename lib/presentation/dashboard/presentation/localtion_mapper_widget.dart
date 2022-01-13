import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';

import 'package:mobile_warehouse/generated/i18n.dart';

class LocationMapperWidget extends StatelessWidget {
  const LocationMapperWidget({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.beachSea,
          border: Border.all(
            color: AppColors.beachSea,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 30),
            ATText(
              text: I18n.of(context).location_mapper,
              fontColor: AppColors.white,
            ),
            SizedBox(width: 10),
            Icon(
              // Based on passwordVisible state choose the icon
              Icons.location_searching_outlined,
              color: AppColors.white,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
