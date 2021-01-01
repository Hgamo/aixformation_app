import 'package:aixformation_app/helper/app_Start.dart';
import 'package:aixformation_app/screens/settings_screen.dart';
import 'package:aixformation_app/shared/website_screen.dart';
import 'package:aixformation_app/widgets/fav_posts.dart';
import 'package:aixformation_app/widgets/home_posts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pagei = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePosts(),
      FavPosts(),
      SettingsScreen(),
    ];
    AppStart.onAppStrat();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pagei,
        onTap: (value) {
          setState(() {
            pagei = value;
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
            label: 'Einstellungen'
          ),
        ],
      ),
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'Über Uns Screen'),
                    builder: (context) => WebsiteScreen(
                      title: 'Über Uns',
                      url: 'https://aixmedia.org/aixformation/',
                    ),
                  ),
                );
              }
              if (value == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'Impressum Screen'),
                    builder: (context) => WebsiteScreen(
                      title: 'Impressum',
                      url: 'https://aixmedia.org/imprint/',
                    ),
                  ),
                );
              }
              if (value == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'Datenschutzerklärung Screen'),
                    builder: (context) => WebsiteScreen(
                      title: 'Datenschutzerklärung',
                      url: 'https://aixformation.de/datenschutzerklaerung/',
                    ),
                  ),
                );
              }
              if (value == 3) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'Genderhinweis Screen'),
                    builder: (context) => WebsiteScreen(
                      title: 'Genderhinweis',
                      url: 'https://aixmedia.org/gender/',
                    ),
                  ),
                );
              }
              if (value == 4) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'aix:media Screen'),
                    builder: (context) => WebsiteScreen(
                      title: 'aix:media',
                      url: 'https://aixmedia.org/',
                    ),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  'Über Uns',
                  style: GoogleFonts.ubuntu(),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  'Impressum',
                  style: GoogleFonts.ubuntu(),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  'Datenschutzerklärung',
                  style: GoogleFonts.ubuntu(),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Text(
                  'Genderhinweis',
                  style: GoogleFonts.ubuntu(),
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Text(
                  'aix:media',
                  style: GoogleFonts.ubuntu(),
                ),
              ),
            ],
          ),
        ],
        centerTitle: true,
        title: Text(
          'AiXformation',
          style: GoogleFonts.arvo(),
        ),
      ),
      body: pages[pagei],
    );
  }
}
