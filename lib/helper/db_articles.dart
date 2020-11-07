import 'dart:convert';
import 'package:http/http.dart' as http;

class DBArticles {
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
