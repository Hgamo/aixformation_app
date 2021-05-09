import 'dart:async';

import 'package:aixformation_app/classes/author.dart';
import 'package:aixformation_app/classes/category.dart';
import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/classes/vac_data.dart';
import 'package:aixformation_app/helper/fav_helper.dart';
import 'package:aixformation_app/helper/get_authors.dart';
import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:aixformation_app/helper/vac_helper.dart';
import 'package:aixformation_app/shared/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rki_corona_api/rki_corona_api.dart' as rki;
import 'provider/landscape_provider.dart';
import 'wrapper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AixformationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SecondApp(),
    );
  }
}

class SecondApp extends StatefulWidget {
  @override
  _SecondAppState createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  StreamSubscription auhtState;
  User user;
  @override
  void initState() {
    auhtState = FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    auhtState.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: user == null ? [Provider(create: (context) => null)]
          : [
              StreamProvider<List<int>>(
                create: (context) => FavHelper.getFavsIds,
                lazy: false,
                initialData: [],
              ),
              StreamProvider<List<Author>>(
                create: (context) => GetAuthors().authors,
                lazy: false,
                initialData: [],
              ),
              StreamProvider<List<Category>>(
                create: (context) => GetCategories().categories,
                lazy: false,
                initialData: [],
              ),
              StreamProvider<List<Post>>(
                create: (context) => GetPosts.getPosts(),
                lazy: false,
                initialData: [],
              ),
              FutureProvider<rki.District>(
                create: (context) => rki.RKICovidAPI.getDisctricts().then(
                  (value) => value.districts.firstWhere(
                      (element) => element.name == 'Städteregion Aachen'),
                ),
                lazy: false,
                initialData: null,
              ),
              FutureProvider<rki.CovidCases>(
                create: (context) => rki.RKICovidAPI.getCases(),
                lazy: false,
                initialData: null,
              ),
              FutureProvider<VacData>(
                create: (context) => VacHelper.getVacData(),
                lazy: false,
                initialData: null,
              ),
              ChangeNotifierProxyProvider<List<Post>, LandScapeProvider>(
                create: (context) => LandScapeProvider(
                    Provider.of<List<Post>>(context, listen: false).first.id),
                update: (context, value, previous) => previous,
              ),
            ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('de'),
        ],
        theme: ThemeSup(
                MediaQuery.of(context).platformBrightness == Brightness.dark)
            .theme(),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        title: 'Auhuur Magazin',
        home: Wrapper(),
      ),
    );
  }
}
