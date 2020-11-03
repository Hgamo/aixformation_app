import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatText extends StatelessWidget {
  final String cat;
  CatText(this.cat);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        cat,
        style: GoogleFonts.ubuntu(),
      ),
    );
  }
}
