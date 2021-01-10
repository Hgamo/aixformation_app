import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'shared/color_white.dart';
import 'wrapper.dart';

class AixformationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: HexColor('#4f6b54'),
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: white,
        accentColor: HexColor('#4f6b54'),
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
      title: 'AiXformation',
      home: Wrapper(),
    );
  }
}
