import 'package:flutter/material.dart';

class Post {
  String contentHtml;
  String featuredMedia;
  String title;
  String excerptHtml;
  int id;
  DateTime date;
  String link;
  int author;
  List categories;

  Post({
    this.categories,
    this.author,
    @required this.title,
    @required this.id,
    this.date,
    @required this.link,
    @required this.featuredMedia,
    @required this.contentHtml,
    @required this.excerptHtml,
  });
}
