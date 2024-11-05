import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
  brightness: Brightness.light,
  surface: Colors.grey.shade100,
  primary: Colors.grey.shade300,
  secondary: Colors.grey.shade900,
  inversePrimary: Colors.grey.shade400,
));
ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
  brightness: Brightness.light,
  surface: Colors.grey.shade900,
  primary: Colors.grey.shade800,
  secondary: Colors.grey.shade400,
  inversePrimary: Colors.grey.shade800,
));
