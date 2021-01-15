import 'package:aixformation_app/shared/color_white.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: white,
  accentColor: Color.fromRGBO(64, 108, 93, 1),
  textTheme: TextTheme(
    headline1: GoogleFonts.arvo(
        fontSize: 101, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.arvo(
        fontSize: 63, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.arvo(fontSize: 50, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.arvo(
        fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.arvo(fontSize: 25, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.arvo(
        fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.arvo(
        fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.arvo(
        fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.ubuntu(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.ubuntu(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.ubuntu(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.ubuntu(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.ubuntu(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: white,
  accentColor: Color.fromRGBO(64, 108, 93, 1),
  textTheme: TextTheme(
    headline1: GoogleFonts.arvo(
        fontSize: 101, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.arvo(
        fontSize: 63, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.arvo(fontSize: 50, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.arvo(
        fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.arvo(fontSize: 25, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.arvo(
        fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.arvo(
        fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.arvo(
        fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.ubuntu(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.ubuntu(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.ubuntu(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.ubuntu(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.ubuntu(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  ),
);

