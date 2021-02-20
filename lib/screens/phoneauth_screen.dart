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
      body: Column(
        children: [
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
                verificationCompleted: (phoneAuthCredential) {
                  print('singn in 2');
                  FirebaseAuth.instance
                      .signInWithCredential(phoneAuthCredential);
                },
                verificationFailed: (error) {
                  if (error.code == 'invalid-phone-number') {
                    print('The provided phone number is not valid.');
                  }
                },
                codeSent: (verificationId, forceResendingToken) async {
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
                          verificationId: verificationId, smsCode: code);
                  await FirebaseAuth.instance
                      .signInWithCredential(phoneAuthCredential);
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
    );
  }
}
