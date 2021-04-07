import 'package:aixformation_app/shared/website_screen.dart';
import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
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
              settings: RouteSettings(name: 'Genderhinweis Screen'),
              builder: (context) => WebsiteScreen(
                title: 'Genderhinweis',
                url: 'https://aixmedia.org/gender/',
              ),
            ),
          );
        }
        if (value == 2) {
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
          child: Text('Über Uns'),
        ),
        PopupMenuItem(
          value: 1,
          child: Text('Genderhinweis'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('aix:media'),
        ),
      ],
    );
  }
}
