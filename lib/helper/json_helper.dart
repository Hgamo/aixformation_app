import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aixformation_app/classes/class_post.dart';

class JsonHelper {
  static Future<bool> isnewestPost(int postId) async {
    final http.Response response = await http
        .get('https://aixformation.de/wp-json/wp/v2/posts?per_page=1&page=1');
    final List data = jsonDecode(response.body);
    int onlineid = data[0]['id'];
    return postId == onlineid;
  }

  static Future<bool> issecondnewestPost(int postId) async {
    final http.Response response = await http
        .get('https://aixformation.de/wp-json/wp/v2/posts?per_page=1&page=2');
    final List data = jsonDecode(response.body);
    int onlineid = data[0]['id'];
    return postId == onlineid;
  }

  static Future<List<Post>> getPosts() async {
    return fromeResponsetoList(await http
        .get('https://aixformation.de/wp-json/wp/v2/posts?per_page=100'));
  }

  static List<Post> fromeResponsetoList(http.Response response) {
    final List jsonposts = jsonDecode(response.body);
    List<Post> posts = [];
    jsonposts.forEach((element) {
      posts.add(
        Post(
          authorId: element['author'],
          title: element['title']['rendered'],
          id: element['id'],
          date: DateTime.parse(element['date']),
          link: element['link'],
          featuredMedia: element['jetpack_featured_media_url'],
          contentHtml: element['content']['rendered'],
          excerptHtml: element['excerpt']['rendered'],
          categoriesId: element['categories'],
        ),
      );
    });
    return posts;
  }

  static Future<Post> getnewestPost() async {
    final posts = fromeResponsetoList(await http
        .get('https://aixformation.de/wp-json/wp/v2/posts?per_page=1&page=1'));
    return posts[0];
  }
}
