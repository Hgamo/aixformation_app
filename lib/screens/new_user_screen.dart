import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String email;
String password;

class NewUserScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'AiXformation',
              style: GoogleFonts.arvo(
                fontSize: 40,
              ),
            ),
            Column(
              children: [
                GoogleAuthButton(
                  onPressed: () async {
                    await Auth.logInWithGoogle();
                    FirebaseAnalytics().setUserId(Auth.getAuthstate().uid);
                    FirebaseAnalytics().setUserProperty(
                        name: 'login_methode', value: 'Google');
                    FirebaseAnalytics().logLogin();
                  },
                  darkMode: MediaQuery.of(context).platformBrightness ==
                      Brightness.dark,
                ),
                MaterialButton(
                  child: Text('Ohne E-Mail Adresse fortfahren'),
                  onPressed: () async {
                    await Auth.logInAny();
                    FirebaseAnalytics().setUserId(Auth.getAuthstate().uid);
                    FirebaseAnalytics()
                        .setUserProperty(name: 'login_methode', value: 'any');
                    FirebaseAnalytics().logLogin();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
