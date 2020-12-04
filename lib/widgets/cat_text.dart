import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatText extends StatelessWidget {
  final String catName;
  CatText(this.catName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Chip(
        backgroundColor: Theme.of(context).accentColor,
        label: Text(
          catName,
          style: GoogleFonts.ubuntu(
            height: 1.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
