import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isdark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                  isdark ? 'assets/logo_dunkel.png' : 'assets/logo_hell.png'),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
