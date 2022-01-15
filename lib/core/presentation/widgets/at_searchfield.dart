import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATSearchfield extends StatefulWidget {
  const ATSearchfield(
      {Key? key, this.hintText, this.textEditingController, this.onPressed})
      : super(key: key);

  final String? hintText;
  final TextEditingController? textEditingController;
  final VoidCallback? onPressed;

  @override
  _ATSearchfield createState() => _ATSearchfield();
}

class _ATSearchfield extends State<ATSearchfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      key: widget.key,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: AppColors.white)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.semiDark),
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(color: AppColors.semiDark),
          hintText: widget.hintText ?? 'Search',
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: AppColors.semiDark),
            onPressed: widget.onPressed ?? () {},
          )),
    );
  }
}