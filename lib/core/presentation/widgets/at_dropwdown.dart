import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATDropdown extends StatefulWidget {
  const ATDropdown({Key? key, this.selectedItem, this.itemList, this.onChange, this.hintText}) : super(key: key);

  final String? hintText;
  final String? selectedItem;
  final List<String>? itemList;
  final Function(String?)? onChange;

  @override
  _ATDropdown createState() => _ATDropdown();
}

class _ATDropdown extends State<ATDropdown> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.white)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: AppColors.semiDark),
            ),
            hintStyle: TextStyle(color: AppColors.semiDark),
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          isEmpty: widget.selectedItem == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down, color: AppColors.beachSea,),
              value: widget.selectedItem,
              isDense: true,
              onChanged: widget.onChange,
              items: widget.itemList!.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}