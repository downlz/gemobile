import 'package:flutter/material.dart';


class AppTextStyle {
  static FontWeight _getFontWeight(bool isBold) {
    FontWeight fontWeight = FontWeight.normal;
    if (isBold) {
      fontWeight = FontWeight.bold;
    }
    return fontWeight;
  }

  static TextStyle getAppBarTextStyle(bool isBold, Color color,
      double fontSize) {
    return TextStyle(
        fontWeight: _getFontWeight(isBold),
        fontStyle: FontStyle.normal,
        color: color);
  }

  static TextStyle getLargeHeading(bool isBold, Color color) {
    return TextStyle(
      fontWeight: _getFontWeight(isBold),
      color: color,

    );
  }

  static TextStyle drawerText(bool isBold, Color color, double fontSize) {
    return TextStyle(
        fontWeight: _getFontWeight(isBold),
        color: color,
        fontSize:fontSize

    );
  }
  static TextStyle commonTextStyle(Color color,double fontSize,FontWeight fontWeight,FontStyle fontStyle) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontStyle: fontStyle,



    );
  }


}
