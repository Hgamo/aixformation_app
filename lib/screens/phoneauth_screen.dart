import 'dart:io';

import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:aixformation_app/shared/color_white.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String number;
  String code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Wir brauchen deine Telefon Nummer',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 20,
            ),
            Theme(
              data: ThemeData(
                brightness:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Brightness.dark
                        : Brightness.light,
                primarySwatch: aixGreen,
              ),
              child: TextField(
                onChanged: (value) => number = value,
                decoration: InputDecoration(
                  labelText: "Telefonnummer",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: number,
                  verificationCompleted: (phoneAuthCredential) async {
                    await FirebaseAuth.instance
                        .signInWithCredential(phoneAuthCredential);
                    await Auth.newUser();
                  },
                  verificationFailed: (error) {
                    if (error.code == 'invalid-phone-number') {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Das ist keine gültige Telefonnummer'),
                        ),
                      );
                    }
                  },
                  codeSent: (verificationId, forceResendingToken) async {
                    print('code send');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    );
                    if (!Platform.isAndroid) {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Code'),
                          content: Theme(
                            data: ThemeData(
                              brightness:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? Brightness.dark
                                      : Brightness.light,
                              primarySwatch: aixGreen,
                            ),
                            child: TextField(
                              onChanged: (value) => value = code,
                              decoration: InputDecoration(
                                labelText: "Überprüfungs code",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      );
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: code,
                      );
                      await FirebaseAuth.instance
                          .signInWithCredential(phoneAuthCredential);
                      await Auth.newUser();
                    }
                  },
                  codeAutoRetrievalTimeout: (verificationId) {
                    print('verrifaciton failed' + verificationId);
                  },
                  timeout: Duration(seconds: 60),
                );
              },
              child: Text('Überprüfen'),
            ),
          ],
        ),
      ),
    );
  }
}
