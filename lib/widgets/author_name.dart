import 'package:aixformation_app/classes/author.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorName extends StatelessWidget {
  final int author;
  final List<Author> allauthors;
  AuthorName({this.author, this.allauthors});

  @override
  Widget build(BuildContext context) {
    final String authorName = (allauthors.firstWhere(
      (element) => author == element.id,
      orElse: () => Author(name: ''),
    )).name;

    return Text(
      authorName == null ? '' : authorName,
      style: GoogleFonts.ubuntu(),
    );
  }
}
