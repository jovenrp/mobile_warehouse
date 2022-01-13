import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/presentation/widgets/theme_state.dart';
import 'package:pedantic/pedantic.dart';

import 'package:mobile_warehouse/generated/i18n.dart';

mixin BackPressedMixin {
  bool onBackPressed(BuildContext context, bool isDoubleBackPressed,
      Function(bool) onDismiss) {
    bool _isDoubleBackPressed = isDoubleBackPressed;
    if (_isDoubleBackPressed) {
      SystemNavigator.pop();
      return true;
    }
    if (!_isDoubleBackPressed) {
      final ThemeState _themeState = context.read<ThemeState>();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(I18n.of(context).dashboard_android_back),
        duration: Duration(seconds: 5),
        padding: EdgeInsets.symmetric(horizontal: _themeState.margin),
      ));
      isDoubleBackPressed = true;
    }

    unawaited(Future<void>.delayed(Duration(seconds: 5)).then((_) {
      isDoubleBackPressed = false;
      onDismiss(isDoubleBackPressed);
    }));

    return isDoubleBackPressed;
  }
}
