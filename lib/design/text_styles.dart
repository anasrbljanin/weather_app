import 'package:flutter/material.dart';
import 'package:weather_app/design/colors.dart';
import 'package:weather_app/design/fonts.dart';

class WeatherTextStyle {
  static TextStyle defaultTextStyle(
      {FontWeight? fontWeight, double fontSize = 16, Color? color}) {
    return TextStyle(
      fontFamily: WeatherFont.inter,
      color: color ?? WeatherColor.highlightBlue,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle header() {
    return TextStyle(
      fontFamily: WeatherFont.inter,
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }
}
