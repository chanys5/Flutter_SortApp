import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;

  static double safeAreaHorizontal;
  static double safeAreaVertical;

  static double sideOffset;
  static double widgetSize;

  static double maxWidthWidgets = 5;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    sideOffset = screenWidth / 10 + safeAreaHorizontal;

    widgetSize = (screenWidth - sideOffset * 2) / maxWidthWidgets;
  }
}
