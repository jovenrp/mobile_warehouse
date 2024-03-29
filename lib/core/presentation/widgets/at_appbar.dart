import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';

class ATAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ATAppBar(
      {Key? key,
      this.appBarHeight,
      this.title,
      this.icon,
      this.onTap,
      this.rotation,
      this.actions})
      : super(key: key);

  final double? appBarHeight;
  final String? title;
  final Icon? icon;
  final VoidCallback? onTap;
  final int? rotation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.beachSea,
      title: ATText(
          text: title ?? '',
          style: TextStyle(
              fontSize: 18,
              color: AppColors.white,
              fontWeight: FontWeight.w700)),
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: onTap ??
            () {
              Navigator.pop(context);
            },
        child: RotatedBox(
          quarterTurns: rotation ?? 0,
          child: icon ??
              Icon(
                Icons.arrow_back_sharp,
                color: AppColors.white,
                size: 24.0,
              ),
        ),
      ),
      actions: actions ?? <Widget>[],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? kToolbarHeight);
}
