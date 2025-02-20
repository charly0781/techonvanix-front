import 'package:flutter/material.dart';

import 'CustomColors.dart';

class CustomData {
  static TextStyle getFontFromName(String fontName, double fontSize, String color) {
    switch (fontName.toLowerCase()) {
      case 'times':
        return TextStyle(fontFamily: 'Times New Roman',
            fontSize: fontSize,
            color: CustomColors.getColorsFromName(color));
      case 'roboto':
        return TextStyle(fontFamily: 'Roboto',
            fontSize: fontSize,
            color: CustomColors.getColorsFromName(color));
      case 'arial':
        return TextStyle(fontFamily: 'Arial',
        fontSize: fontSize,
        color: CustomColors.getColorsFromName(color));
      default:
        return TextStyle(fontFamily: 'Times New Roman',
            fontSize: fontSize,
            color: CustomColors.getColorsFromName(color));
    }
  }
}
