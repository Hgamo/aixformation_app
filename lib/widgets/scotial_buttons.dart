import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SoctialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FlatButton(
          onPressed: () {
            launch('https://chat.whatsapp.com/invite/IrT0Tl5VTAJEwscmGPtSzp');
          },
          child: Text('WhatsApp'),
        ),
        FlatButton(
          onPressed: () {
            launch('https://instagram.com/aixformation');
          },
          child: Text('Instagram'),
        ),
        FlatButton(
          onPressed: () {
            launch('https://www.twitter.com/aixformation');
          },
          child: Text('Twitter'),
        ),
        FlatButton(
          onPressed: () {
            launch('https://t.me/aixformation');
          },
          child: Text('Telegram'),
        ),
        FlatButton(
          onPressed: () {
            launch('https://www.facebook.com/AiXformation/');
          },
          child: Text('Facebook'),
        ),
      ],
      scrollDirection: Axis.horizontal,
    );
  }
}
