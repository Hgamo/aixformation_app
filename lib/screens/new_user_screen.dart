import 'dart:io';

import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:aixformation_app/screens/phoneauth_screen.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:aixformation_app/screens/e-mail_screen.dart';

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
              'Auhuur Magazin !',
              style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 50,),
              textAlign: TextAlign.center,
            ),
            Column(
              children: [
                GoogleAuthButton(
                  style: AuthButtonStyle(borderRadius: 10),
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
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Mit E-Mail Adresse Einloggen'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EMailScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                if(!Platform.isIOS)
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Mit Telefonnummer Einloggen'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PhoneAuthScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                MaterialButton(
                  child: Text('Ohne E-Mail Adresse fortfahren'),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AnyDialog(),
                    );
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

class AnyDialog extends StatefulWidget {
  @override
  _AnyDialogState createState() => _AnyDialogState();
}

class _AnyDialogState extends State<AnyDialog> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Dialog(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : AlertDialog(
            title: Text('Achtung'),
            content: Text(
                'Wenn du dich ohne E-Mail Adresse angemeldest, können deine Daten nicht wiederhergestellt werden.'),
            actions: [
              MaterialButton(
                textColor: Theme.of(context).errorColor,
                child: Text('Trotzdem fortfahren'),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Auth.logInAny();
                  FirebaseAnalytics().setUserId(Auth.getAuthstate().uid);
                  FirebaseAnalytics()
                      .setUserProperty(name: 'login_methode', value: 'any');
                  FirebaseAnalytics().logLogin();
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                textColor: Theme.of(context).accentColor,
                child: Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
  }
}
