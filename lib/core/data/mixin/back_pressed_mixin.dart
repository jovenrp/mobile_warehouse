import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/presentation/dashboard/bloc/dashbordscreeen_bloc.dart';
import 'package:pedantic/pedantic.dart';

mixin BackPressedMixin {
  bool onBackPressed(BuildContext context, bool isDoubleBackPressed,
      Function(bool) onDismiss) {
    bool _isDoubleBackPressed = isDoubleBackPressed;
    if (_isDoubleBackPressed) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      context.read<DashboardScreenBloc>().logout();
      return true;
    }
    if (!_isDoubleBackPressed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Press back again to logout.'),
            duration: Duration(seconds: 5)),
      );
      isDoubleBackPressed = true;
    }

    unawaited(Future<void>.delayed(Duration(seconds: 5)).then((_) {
      isDoubleBackPressed = false;
      onDismiss(isDoubleBackPressed);
    }));

    return isDoubleBackPressed;
  }
}
