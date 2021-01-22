import 'package:aixformation_app/shared/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'wrapper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AixformationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('de'),
      ],
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      theme: theme,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
      title: 'AiXformation',
      home: Wrapper(),
    );
  }
}
