
import 'package:flutter/material.dart';

class CustomColors {
  static Color getColorsFromName(String colorName) {
    switch (colorName) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'cyan':
        return Colors.cyan;
      case 'teal':
        return Colors.teal;
      case 'amber':
        return Colors.amber;
      case 'indigo':
        return Colors.indigo;
      case 'lime':
        return Colors.lime;
      case 'brown':
        return Colors.brown;
      case 'grey':
        return Colors.grey;
      case 'blueGrey':
        return Colors.blueGrey;
      case 'deepPurple':
        return Colors.deepPurple;
      case 'deepOrange':
        return Colors.deepOrange;
      case 'lightBlue':
        return Colors.lightBlue;
      case 'lightGreen':
        return Colors.lightGreen;
      case 'amberAccent':
        return Colors.amberAccent;
      case 'blueAccent':
        return Colors.blueAccent;
      case 'cyanAccent':
        return Colors.cyanAccent;
        case 'darkGrey':
        return Colors.grey[850]!;
      default:
        return Colors.black;
    }
  }
}