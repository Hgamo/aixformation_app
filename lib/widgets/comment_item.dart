import 'package:aixformation_app/classes/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  CommentItem(this.comment);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launch(comment.link),
          child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
            title: Text(comment.authorName),
            subtitle: Text(
              DateFormat('dd.MM.yyyy').format(comment.date) +
                  ' um ' +
                  DateFormat('HH:mm').format(comment.date),
            ),
          ),
          HtmlWidget(comment.content),
        ],
      ),
    );
  }
}
