import 'package:aixformation_app/classes/author.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(imageUrl: author.avatarUrl,fit:  BoxFit.cover,),
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
