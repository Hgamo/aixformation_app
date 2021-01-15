import 'package:aixformation_app/screens/main_screen.dart';
import 'package:aixformation_app/screens/new_user_screen.dart';
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
          return InternetScreen();
        }
        //eingelogt direkt zum MainScreen
        return MainScreen();
      },
    );
  }
}

class InternetScreen extends StatefulWidget {
  @override
  _InternetScreenState createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Connectivity().checkConnectivity(),
      builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
        final result = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done) {
          if (result == ConnectivityResult.none) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Um mit der App zu starten, musst du mit dem Internet verbunden sein.',
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Erneut versuchen',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => setState(() {}),
                    ),
                  ],
                ),
              ),
            );
          }
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            //mit dem Internet Verbunden
            return NewUserScreen();
          }
        }
        return Container();
      },
    );
  }
}
