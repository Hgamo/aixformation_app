import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatText extends StatefulWidget {
  final String cat;
  CatText(this.cat);
  @override
  _CatTextState createState() => _CatTextState();
}

class _CatTextState extends State<CatText> {
  bool vis = false;
  changeOpacity() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        vis = !vis;
      });
    });
  }

  @override
  void initState() {
    changeOpacity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: vis ? 1 : 0,
      child: Chip(
        label: Text(
          widget.cat,
          style: GoogleFonts.ubuntu(),
        ),
      ),
    );
  }
}
