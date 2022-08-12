import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATMiniTextfield extends StatefulWidget {
  const ATMiniTextfield(
      {Key? key,
      this.hintText,
      this.textEditingController,
      this.qtyPick,
      this.onChanged,
      this.autoFocus,
      this.onFieldSubmitted,
      this.iconPressed})
      : super(key: key);

  final String? hintText;
  final TextEditingController? textEditingController;
  final String? qtyPick;
  final bool? autoFocus;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final VoidCallback? iconPressed;

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
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[.\-0-9]'))],
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        hintStyle: TextStyle(color: AppColors.beachSea),
        fillColor: Colors.white70,
        suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).primaryColorDark,
              size: 20,
            ),
            onPressed: widget.iconPressed),
      ),
    );
  }
}
