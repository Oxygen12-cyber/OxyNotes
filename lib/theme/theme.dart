import 'package:flutter/material.dart';

final lighttheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff3953b8),
    onError: Colors.red[200],
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xffffffff),
  appBarTheme: AppBarThemeData(
    surfaceTintColor: Colors.transparent,

    backgroundColor: Color(0xffffffff),
    foregroundColor: Colors.black,
  ),
);

final darktheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff4a54ff),
    onError: Colors.red[200],
    surfaceBright: Colors.blueAccent[400],

    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: const Color(0xff0d1333),
  appBarTheme: AppBarThemeData(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Color(0xff0d1333),
    foregroundColor: Colors.white,
  ),
);
