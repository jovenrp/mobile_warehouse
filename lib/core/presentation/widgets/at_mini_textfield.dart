import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATMiniTextfield extends StatefulWidget {
  const ATMiniTextfield(
      {Key? key,
      this.hintText,
      this.textEditingController,
      this.qtyPick,
      this.onChanged,
      this.autoFocus,
      this.onFieldSubmitted})
      : super(key: key);

  final String? hintText;
  final TextEditingController? textEditingController;
  final String? qtyPick;
  final bool? autoFocus;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;

  @override
  _ATMiniTextfield createState() => _ATMiniTextfield();
}

class _ATMiniTextfield extends State<ATMiniTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      key: widget.key,
      onFieldSubmitted: widget.onFieldSubmitted,
      autofocus: widget.autoFocus ?? false,
      keyboardType: TextInputType.number,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        hintStyle: TextStyle(color: AppColors.beachSea),
        hintText: 'Enter a text here',
        fillColor: Colors.white70,
      ),
    );
  }
}
