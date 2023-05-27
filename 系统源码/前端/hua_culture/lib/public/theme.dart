import 'package:flutter/material.dart';
import 'config.dart';

class HTheme {
  static const double paddingSizeSmall = 4;
  static const double paddingSizeNormal = 8;
  static const double paddingSizeLarge = 14;

  static const double marginSizeSmall = 4;
  static const double marginSizeNormal = 8;
  static const double marginSizeLarge = 14;
  
  static const double fontSizeSmall = 12;
  static const double fontSizeNormal = 14;
  static const double fontSizeLarge = 16;

  static const fontWeightLight = FontWeight.w200;
  static const fontWeightNormal = FontWeight.w500;
  static const fontWeightHeary = FontWeight.w700;

  static ThemeData _theme;
  static ThemeData get theme {
    if(_theme == null || HConfig.debug) {
      _theme = ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
        accentColor: Colors.blueGrey,
        accentColorBrightness: Brightness.dark,
        buttonColor: Colors.blueGrey,
      );
    }
    return _theme;
  }
}