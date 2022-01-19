import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATMiniTextfield extends StatefulWidget {
  const ATMiniTextfield(
      {Key? key,
      this.hintText,
      this.textEditingController,
      this.qtyPick,
      this.onChanged})
      : super(key: key);

  final String? hintText;
  final TextEditingController? textEditingController;
  final String? qtyPick;
  final Function(String?)? onChanged;

  @override
  _ATMiniTextfield createState() => _ATMiniTextfield();
}

class _ATMiniTextfield extends State<ATMiniTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      key: widget.key,
      keyboardType: TextInputType.number,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        hintStyle: TextStyle(color: AppColors.beachSea),
        hintText: widget.hintText ?? 'Enter a text here',
        fillColor: Colors.white70,
      ),
    );
  }
}
