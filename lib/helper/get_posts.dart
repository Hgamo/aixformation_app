import 'dart:convert';
import 'package:aixformation_app/classes/author.dart';
import 'package:http/http.dart' as http;
import 'package:aixformation_app/classes/class_post.dart';
import 'package:http/http.dart';

class GetPosts {
  Future<List<Post>> getPosts() async {
    return fromeResponsetoList(await http
        .get('https://aixformation.de/wp-json/wp/v2/posts?per_page=100'));
  }

  List<Post> fromeResponsetoList(Response response) {
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
          categories: element['categories'],
        ),
      );
    });
    return posts;
  }

  Future<String> getauthor(int author) async {
    final List authors = jsonDecode(
        (await http.get('https://aixformation.de/wp-json/wp/v2/users?id=0'))
            .body);
    return (authors.firstWhere((element) => element['id'] == author))['name'];
  }

  Future<List<Author>> getallauthors() async {
    final List dataAuthors = jsonDecode(
        (await http.get('https://aixformation.de/wp-json/wp/v2/users?id=0'))
            .body);
    List<Author> authors = [];
    dataAuthors.forEach((element) {
      authors.add(Author(id: element['id'], name: element['name']));
    });
    return authors;
  }
}
