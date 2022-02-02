import 'package:flutter/cupertino.dart';
import 'package:mobile_warehouse/generated/assets.gen.dart';

class ApplicationLogo extends StatelessWidget {
  const ApplicationLogo({Key? key, this.height, this.width, this.image})
      : super(key: key);

  final double? height;
  final double? width;
  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image(
        width: width ?? 180,
        height: height ?? 180,
        fit: BoxFit.fitHeight,
        image: image ?? Assets.images.applogo,
      ),
    );
  }
}
