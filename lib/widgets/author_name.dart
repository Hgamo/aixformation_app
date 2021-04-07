import 'package:aixformation_app/classes/author.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorName extends StatelessWidget {
  final int authorId;

  AuthorName({
    this.authorId,
  });

  @override
  Widget build(BuildContext context) {
    final authors = Provider.of<List<Author>>(context);
    final String authorName =
        authors.firstWhere((element) => element.id == authorId).name;
    return Text(authorName);
  }
}
