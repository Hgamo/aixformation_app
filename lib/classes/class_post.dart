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
  List categoriesId;

  Post({
    @required this.categoriesId,
    @required this.authorId,
    @required this.title,
    @required this.id,
    @required this.date,
    @required this.link,
    @required this.featuredMedia,
    @required this.contentHtml,
    @required this.excerptHtml,
  });
}
