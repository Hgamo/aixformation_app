import 'dart:async';
import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:aixformation_app/helper/remote_config_helper.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:aixformation_app/shared/popUpMenu.dart';
import 'package:aixformation_app/widgets/fragments/covid_fragment.dart';
import 'package:aixformation_app/widgets/fragments/settings_fragment.dart';
import 'package:aixformation_app/widgets/fragments/fav_fragment.dart';
import 'package:aixformation_app/widgets/fragments/home_fragment.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void handleMessage() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      final Post post =
          await GetPosts.getPostById(int.parse(message.data['post_id']));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostScreen(post),
      ));
    }
  }

  void handleFBLinks() async {
    final fBLinks = FirebaseDynamicLinks.instance;
    fBLinks.onLink(
      onSuccess: (linkData) async {
        final parameters = linkData.link.queryParameters;
        final post = await GetPosts.getPostById(int.parse(parameters['p']));
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostScreen(post),
        ));
      },
      onError: (error) {
        print(error.message);
        return;
      },
    );
    final linkData = await fBLinks.getInitialLink();
    if (linkData != null) {
      final parameters = linkData.link.queryParameters;
      final post = await GetPosts.getPostById(int.parse(parameters['p']));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostScreen(post),
      ));
    }
  }

  int pagei = 0;
  PageController _pageController;
  StreamSubscription fcmStream;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fcmStream = FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      final Post post =
          await GetPosts.getPostById(int.parse(message.data['post_id']));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostScreen(post),
      ));
    });
    handleMessage();
    handleFBLinks();
  }

  @override
  void dispose() {
    _pageController.dispose();
    fcmStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeFragment(),
      FavFragment(),
      if (Provider.of<RemoteConfigHelper>(context).showCovid()) CovidFragment(),
      SettingsFragment(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: pagei,
        onTap: (value) {
          setState(() {
            pagei = value;
            _pageController.jumpToPage(
              value,
              // duration: Duration(milliseconds: 300),
              // curve: Curves.easeOut,
            );
          });
        },
        fixedColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Artikel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriten',
          ),
          if (Provider.of<RemoteConfigHelper>(context).showCovid())
            BottomNavigationBarItem(
              icon: Icon(Icons.coronavirus),
              label: 'Corona',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Einstellungen',
          ),
        ],
      ),
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => Share.share('https://aixformation.page.link/app'),
          ),
          PopUpMenu(),
        ],
        centerTitle: true,
        title: Text(
          'AiXformation',
        ),
      ),
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            pagei = value;
            FirebaseAnalytics().logEvent(
              name: 'changed_page',
              parameters: {
                'page_index': pagei,
              },
            );
          });
        },
        controller: _pageController,
        children: pages,
      ),
    );
  }
}
