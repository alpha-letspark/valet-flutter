import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData basicTheme() {
  final ThemeData base = ThemeData.light();
  final ColorScheme scheme = ColorScheme.light();

  return base.copyWith(
    textTheme: GoogleFonts.robotoTextTheme(),
    colorScheme: scheme.copyWith(
      primary: const Color(0xffFF7900),
    ),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.raleway(), hintStyle: GoogleFonts.raleway()),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
    ),
    primaryColor: const Color(0xffFF7900),
    primaryColorDark: const Color(0xff007C84),
    primaryColorLight: const Color.fromARGB(255, 5, 165, 176),
  );
}
