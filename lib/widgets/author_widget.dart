import 'package:aixformation_app/classes/author.dart';
import 'package:flutter/material.dart';

class AuthorWidget extends StatelessWidget {
  final Author author;
  AuthorWidget(this.author);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        ListTile(
          onTap: () {},
          leading: CircleAvatar(
            child: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
          title: Text(author.name ?? ''),
          subtitle: author.description.isEmpty
              ? null
              : Text(author.description ?? ''),
        ),
        Divider(),
      ],
    );
  }
}
