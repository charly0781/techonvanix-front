import 'package:flutter/material.dart';

import 'CustomColors.dart';

class CustomData {
  static TextStyle getFontFromName(String fontName, double fontSize, String color,
      bool isBold) {
    switch (fontName.toLowerCase()) {
      case 'times':
        return TextStyle(fontFamily: 'Times New Roman',
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: CustomColors.getColorsFromName(color));
      case 'roboto':
        return TextStyle(fontFamily: 'Roboto',
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: CustomColors.getColorsFromName(color));
      case 'arial':
        return TextStyle(fontFamily: 'Arial',
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: CustomColors.getColorsFromName(color));
      case 'playfairDisplay':
        return TextStyle(fontFamily: 'playfairDisplay',
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: CustomColors.getColorsFromName(color));
      default:
        return TextStyle(fontFamily: 'Times New Roman',
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: CustomColors.getColorsFromName(color));
    }
  }
}
