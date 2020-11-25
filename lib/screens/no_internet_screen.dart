import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Um mit der App zu starten, musst du mit dem Internet verbunden sein.',
          ),
        ),
      ),
    );
  }
}
