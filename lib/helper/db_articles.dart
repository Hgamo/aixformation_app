import 'dart:convert';

//import 'package:aixformation_app/classes/class_post.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class DBArticles {
  // storePost(Post post) async {
  //   Database db = await openDatabase('posts');
  //   db.insert(post.id.toString(), {
  //     'contentHtml': post.contentHtml,
  //     'featuredMedia': post.featuredMedia,
  //     'title': post.title,
  //     'excerptHtml': post.excerptHtml,
  //     'id': post.id,
  //     'date': post.date,
  //     'link': post.link,
  //     'author': post.author,
  //     'categories': post.categories,
  //   });
  // }

  static Future<bool> isnewestPost(int postId) async {
    final http.Response response = await http
        .get('https://aixformation.de/wp-json/wp/v2/posts?per_page=1&page=1');
    final List data = jsonDecode(response.body);
    int onlineid = data[0]['id'];
    return postId == onlineid;
  }
  static Future<bool> issecondPost(int postId) async {
    final http.Response response = await http
        .get('https://aixformation.de/wp-json/wp/v2/posts?per_page=1&page=2');
    final List data = jsonDecode(response.body);
    int onlineid = data[0]['id'];
    return postId == onlineid;
  }
}
