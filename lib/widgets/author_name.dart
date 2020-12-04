import 'package:aixformation_app/helper/get_authors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorName extends StatelessWidget {
  final int authorId;

  AuthorName({
    this.authorId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetAuthors.getAuthorNameById(authorId),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(
            snapshot.data,
            style: GoogleFonts.ubuntu(
              height: 1.5,
            ),
          );
        }
        return Container();
      },
    );
  }
}
