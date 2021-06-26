import 'dart:convert';

import 'package:aixformation_app/classes/comment.dart';
import 'package:http/http.dart' as http;

class CommentHelper {
  static Future<List<Comment>> getComments(int postId) async {
    final response = await http
        .get(Uri.parse('https://auhuurmagazin.de/wp-json/wp/v2/comments?post=$postId'));
    final List data = jsonDecode(response.body);
    List<Comment> comments = [];
    data.forEach((map) {
      comments.add(Comment.formMap(map));
    });
    return comments;
  }
}
