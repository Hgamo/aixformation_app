import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SoctialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          onPressed: () {
            launch('https://chat.whatsapp.com/invite/IrT0Tl5VTAJEwscmGPtSzp');
            FirebaseAnalytics().logEvent(
              name: 'social_buttons',
              parameters: {
                'platform': 'WhatsApp',
              },
            );
          },
          child: Text('WhatsApp'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          onPressed: () {
            launch('https://instagram.com/auhuurmagazin');
            FirebaseAnalytics().logEvent(
              name: 'social_buttons',
              parameters: {
                'platform': 'Instagram',
              },
            );
          },
          child: Text('Instagram'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          onPressed: () {
            launch('https://twitter.com/auhuurmagazin');
            FirebaseAnalytics().logEvent(
              name: 'social_buttons',
              parameters: {
                'platform': 'Twitter',
              },
            );
          },
          child: Text('Twitter'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          onPressed: () {
            launch('https://telegram.me/auhuurmagazin');
            FirebaseAnalytics().logEvent(
              name: 'social_buttons',
              parameters: {
                'platform': 'Telegram',
              },
            );
          },
          child: Text('Telegram'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          onPressed: () {
            launch('https://facebook.com/auhuurmagazin');
            FirebaseAnalytics().logEvent(
              name: 'social_buttons',
              parameters: {
                'platform': 'Facebook',
              },
            );
          },
          child: Text('Facebook'),
        ),
      ],
      scrollDirection: Axis.horizontal,
    );
  }
}
