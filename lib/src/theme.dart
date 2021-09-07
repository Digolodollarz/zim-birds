import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() => ThemeData(
      primaryColor: Colors.deepOrange,
      textTheme: GoogleFonts.titilliumWebTextTheme(TextTheme(
        headline6: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        headline5: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        headline4: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 26,
          color: Colors.black87
        ),
        bodyText1: TextStyle(color: Color(0xFF494949)),
        bodyText2: TextStyle(
            color: Color(0xFF696969),
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            height: 1.5),
      )),
    );

class AppTheme {
  static const borderRadius = 8.0;
  static const padding = 20.0;
}
