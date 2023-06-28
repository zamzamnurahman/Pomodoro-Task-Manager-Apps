import 'package:flutter/material.dart';

const Color primary = Color(0xffF55635);
const Color secondary = Color(0xff70CB51);

ThemeData themeData = ThemeData(
    fontFamily: "Poppins",
    primaryColor: primary,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: primary,
      secondary: secondary,
      onSecondary: secondary,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white,
      onBackground: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
    ));
