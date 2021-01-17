import 'dart:async';
import 'package:aixformation_app/classes/author.dart';
import 'package:aixformation_app/classes/category.dart';
import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/fav_helper.dart';
import 'package:aixformation_app/helper/get_authors.dart';
import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:aixformation_app/shared/popUpMenu.dart';
import 'package:aixformation_app/widgets/fragments/settings_fragment.dart';
import 'package:aixformation_app/widgets/fragments/fav_fragment.dart';
import 'package:aixformation_app/widgets/fragments/home_fragment.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void handleMessage() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    print(message);
    if (message != null) {
      final Post post =
          await GetPosts.getPostById(int.parse(message.data['post_id']));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostScreen(post),
      ));
    }
  }

  int pagei = 0;
  final List<Widget> pages = [
    HomeFragment(),
    FavFragment(),
    SettingsFragment(),
  ];
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
  }

  @override
  void dispose() {
    _pageController.dispose();
    fcmStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
        StreamProvider<List<Post>>(
          create: (context) => GetPosts.getPosts(),
          lazy: false,
        )
      ],
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pagei,
          onTap: (value) {
            setState(() {
              pagei = value;
              _pageController.animateToPage(
                value,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
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
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Einstellungen',
            ),
          ],
        ),
        appBar: AppBar(
          actions: [
            PopUpMenu(),
          ],
          centerTitle: true,
          title: Text(
            'AiXformation',
            style: GoogleFonts.arvo(),
          ),
        ),
        body: PageView(
          onPageChanged: (value) {
            setState(() {
              pagei = value;
            });
          },
          controller: _pageController,
          children: pages,
        ),
      ),
    );
  }
}
