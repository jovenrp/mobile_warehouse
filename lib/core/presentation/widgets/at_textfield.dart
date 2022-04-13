import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ATTextfield extends StatefulWidget {
  const ATTextfield(
      {Key? key,
      this.hintText,
      this.isPasswordField = false,
      this.textEditingController})
      : super(key: key);

  final String? hintText;
  final bool isPasswordField;
  final TextEditingController? textEditingController;

  @override
  _ATTextfield createState() => _ATTextfield();
}

class _ATTextfield extends State<ATTextfield> {
  bool _passwordNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      key: widget.key,
      obscureText: widget.isPasswordField ? _passwordNotVisible : false,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: widget.hintText ?? 'Enter a text here',
          fillColor: AppColors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: widget.isPasswordField
                ? Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordNotVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  )
                : const Icon(Icons.clear),
            onPressed: widget.isPasswordField
                ? () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordNotVisible = !_passwordNotVisible;
                    });
                  }
                : () {
                    setState(() {
                      widget.textEditingController?.clear();
                    });
                  },
          )),
    );
  }
}
