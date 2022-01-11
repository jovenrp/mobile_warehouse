import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';

class ThemeState {
  ThemeState({
    required this.theme,
    required this.themeDark,
    double devicePixelRatio = 1,
    double spacingUnit = 8.0,
    double cornerRadiusDefault = 6.0,
  })  : _cornerRadiusDefault = cornerRadiusDefault,
        _spacingUnit = spacingUnit,
        _devicePixelRatio = devicePixelRatio,
        _defaultBorderSide = BorderSide(
          color: AppColors.silver,
          width: 1.0 / devicePixelRatio,
        ),
        super();

  final ThemeData theme;
  final ThemeData themeDark;
  final double _devicePixelRatio;
  final double _spacingUnit; // Use getters below
  final double _cornerRadiusDefault; // Use getters below
  final BorderSide _defaultBorderSide;

  double get spacingTiny => _spacingUnit / 2;

  double get spacingSmall => _spacingUnit;

  double get spacingDefault => _spacingUnit * 2;

  double get spacingMedium => _spacingUnit * 3;

  double get spacingLarge => _spacingUnit * 4;

  double get spacingExtraLarge => _spacingUnit * 6;

  double get spacingHuge => _spacingUnit * 8;

  double get cornerRadiusDefault => _cornerRadiusDefault;

  double get hairlineWidth => 1 / _devicePixelRatio;

  double get margin => spacingDefault;

  double get verticalMargin => spacingLarge;

  double get toastSpacing => spacingDefault;

  // CircularIntervalList<double> get dashInterval =>
  //     CircularIntervalList([4.0, 4.0]);

  BorderSide get defaultBorderSide => _defaultBorderSide;

  Widget get defaultKeyboardDown => Padding(
        padding: EdgeInsets.only(right: spacingDefault),
        child: const Icon(Icons.keyboard_hide),
      );

  Border get defaultBorder => Border.all(
        width: _defaultBorderSide.width,
        color: _defaultBorderSide.color,
      );

  BoxShadow get defaultBoxShadow => BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 15.0,
        offset: const Offset(0, 10.0),
      );

  Shadow get defaultTextShadow => Shadow(
        offset: const Offset(1.0, 1.0),
        blurRadius: 2.0,
        color: Colors.black.withOpacity(1),
      );

  double pinBoxWidth(double widthBlock) => widthBlock < 360 ? 38 : 48;

  double get maxWidthContent => 484;

  double get dialogMargin => margin;

  double get maxWidthDialog => maxWidthContent;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ThemeState &&
        o.theme == theme &&
        o.themeDark == themeDark &&
        o._devicePixelRatio == _devicePixelRatio &&
        o._spacingUnit == _spacingUnit &&
        o._cornerRadiusDefault == _cornerRadiusDefault &&
        o._defaultBorderSide == _defaultBorderSide;
  }

  @override
  int get hashCode {
    return theme.hashCode ^
        themeDark.hashCode ^
        _devicePixelRatio.hashCode ^
        _spacingUnit.hashCode ^
        _cornerRadiusDefault.hashCode ^
        _defaultBorderSide.hashCode;
  }
}

class ThemeStateTablet extends ThemeState {
  ThemeStateTablet({
    required ThemeData theme,
    required ThemeData themeDark,
    double devicePixelRatio = 1,
    double spacingUnit = 8.0,
    double cornerRadiusDefault = 6.0,
  }) : super(
          theme: theme,
          themeDark: themeDark,
        );

  @override
  double get margin => spacingLarge;

  @override
  double get verticalMargin => spacingHuge;

  @override
  double get toastSpacing => spacingLarge;

  @override
  double pinBoxWidth(double widthBlock) => 63;

  @override
  double get dialogMargin => 0;

  @override
  double get maxWidthDialog => maxWidthContent + margin * 2;
}
