import 'package:flutter/material.dart';

class CatText extends StatelessWidget {
  final String catName;
  CatText(this.catName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Chip(
        elevation: 5,
        backgroundColor: Theme.of(context).accentColor,
        label: Text(
          catName,
          style: TextStyle(color: Colors.white, height: 1),
        ),
      ),
    );
  }
}
