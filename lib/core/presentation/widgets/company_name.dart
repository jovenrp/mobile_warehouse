import 'package:flutter/cupertino.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class CompanyName extends StatelessWidget {
  const CompanyName(
      {Key? key,
      required this.firstname,
      required this.lastname,
      this.firstnameStyle,
      this.lastnameStyle})
      : super(key: key);

  final String firstname;
  final String lastname;
  final TextStyle? firstnameStyle;
  final TextStyle? lastnameStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(firstname,
            style: firstnameStyle ??
                const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                )),
        Text(lastname,
            style: lastnameStyle ??
                const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.beachSea,
                )),
      ],
    );
  }
}
