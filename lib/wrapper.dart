import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:aixformation_app/screens/main_screen.dart';
import 'package:aixformation_app/screens/no_internet_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.data == null) {
          //noch nicht eingelogt
          return StreamBuilder(
            initialData: ConnectivityResult.none,
            stream: Connectivity().onConnectivityChanged,
            builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
              final result = snapshot.data;
              if (result == ConnectivityResult.none) {
                //nicht mit dem Internet verbunden
                return NoInternetScreen();
              }
              if (result == ConnectivityResult.mobile ||
                  result == ConnectivityResult.wifi) {
                //mit dem Internet Verbunden
                login();
              }
              //ConnectivityResult noch nicht vorhanden
              return Container();
            },
          );
        }
        //eingelogt direkt zum MainScreen
        return MainScreen();
      },
    );
  }

  Future login() async {
    await Auth.loginAn();
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('fav').doc(Auth.getAuthstae().uid).set(
      {},
      SetOptions(merge: true),
    );
  }
}
