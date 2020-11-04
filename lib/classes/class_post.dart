import 'package:flutter/material.dart';

class Post {
  String contentHtml;
  String featuredMedia;
  String title;
  String excerptHtml;
  int id;
  DateTime date;
  String link;
  int authorId;
  List categories;

  Post({
    this.categories,
    this.authorId,
    @required this.title,
    @required this.id,
    this.date,
    @required this.link,
    @required this.featuredMedia,
    @required this.contentHtml,
    @required this.excerptHtml,
  });
}
