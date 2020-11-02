import 'package:flutter/material.dart';

class E404Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Du bist nicht mit dem Internet verbunden, bitte überprüfe deine Einstellungen',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Image.asset('assets/404-page.gif'),
            ],
          ),
        ),
      ),
    );
  }
}
