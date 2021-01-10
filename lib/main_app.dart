import 'package:aixformation_app/classes/author.dart';
import 'package:aixformation_app/classes/category.dart';
import 'package:aixformation_app/helper/fav_helper.dart';
import 'package:aixformation_app/helper/get_authors.dart';
import 'package:aixformation_app/helper/get_categories.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'shared/color_white.dart';
import 'wrapper.dart';

class AixformationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<FavProvider>(
        //   create: (context) => FavProvider(),
        //   lazy: false,
        // ),
        StreamProvider<List<int>>(
          create: (context) => FavHelper.getFavsIds,
          lazy: false,
        ),
        StreamProvider<List<Author>>(
          create: (context) => GetAuthors().authors,
          lazy: false,
        ),
        StreamProvider<List<Category>>(
          create: (context) => GetCategories().categories,
          lazy: false,
        ),
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: HexColor('#4f6b54'),
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
        ),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        title: 'AiXformation',
        home: Wrapper(),
      ),
    );
  }
}
