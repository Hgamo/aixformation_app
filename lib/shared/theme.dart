import 'package:aixformation_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeSup {
  bool isDark;
  ThemeSup(this.isDark);
  ThemeData theme() {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: ahYellow,
      accentColor: ahYellow,
      textTheme: TextTheme(
        headline1: GoogleFonts.zillaSlab(
          fontSize: 101,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
        ),
        headline2: GoogleFonts.zillaSlab(
          fontSize: 63,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
        ),
        headline3: GoogleFonts.zillaSlab(
          fontSize: 50,
          fontWeight: FontWeight.w400,
        ),
        headline4: GoogleFonts.zillaSlab(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headline5: GoogleFonts.zillaSlab(
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
        headline6: GoogleFonts.zillaSlab(
          fontSize: 21,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        subtitle1: GoogleFonts.zillaSlab(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        subtitle2: GoogleFonts.zillaSlab(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyText1: GoogleFonts.lora(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.7,
        ),
        bodyText2: GoogleFonts.lora(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.7,
        ),
        button: GoogleFonts.asap(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        caption: GoogleFonts.asap(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        overline: GoogleFonts.asap(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
