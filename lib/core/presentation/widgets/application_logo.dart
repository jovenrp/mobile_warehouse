import 'package:flutter/cupertino.dart';
import 'package:mobile_warehouse/generated/assets.gen.dart';

class ApplicationLogo extends StatelessWidget {
  const ApplicationLogo({Key? key, this.height, this.width}) : super(key: key);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image(
        width: height ?? 180,
        height: width ?? 180,
        fit: BoxFit.fitHeight,
        image: Assets.images.applogo,
      ),
    );
  }
}
