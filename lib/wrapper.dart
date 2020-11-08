import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:aixformation_app/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    User user = Auth.getAuthstae();
    if (user == null) {
      print('noch nicht eingelogt');
      //noch nicht eingelogt
      return FutureBuilder(
        future: Connectivity().checkConnectivity(),
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == ConnectivityResult.none) {
              print('nicht mit dem Internetverbunden');
              //nicht mit dem Internetverbunden
              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Um mit der App zu starten musst du mit dem Internet verbunden sein',
                        ),
                        RaisedButton(
                          textColor: Colors.white,
                          color: Theme.of(context).accentColor,
                          child: Text('Erneut versuchen'),
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            print('Mit dem Internetverbunden /n Einloggen');
            // Mit dem Internetverbunden
            //Einloggen
            return FutureBuilder(
              future: login(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return MainScreen();
                }
                return Container();
              },
            );
          }
          print('Connectivity result noch nicht dar');
          //Connectivity result noch nicht dar
          return Container();
        },
      );
    }
    return MainScreen();
  }
}

Future login() async {
  await Auth.loginAn();
  final firestore = FirebaseFirestore.instance;
  await firestore.collection('fav').doc(Auth.getAuthstae().uid).set(
    {},
    SetOptions(merge: true),
  );
}
