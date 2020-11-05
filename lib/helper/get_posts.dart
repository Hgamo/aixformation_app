import 'dart:convert';
import 'package:aixformation_app/classes/author.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:aixformation_app/classes/class_post.dart';
import 'package:http/http.dart';

class GetPosts {
  static Future<List<Post>> getFirebasePosts() async {
    final firestore = FirebaseFirestore.instance;
    final dataPosts = await firestore.collection('posts').get();

    final dataPostLists = dataPosts.docs;

    List<Post> posts = [];

    dataPostLists.forEach((element) {
      final postData = element.data();

      posts.add(
        Post(
          categoriesId: postData['categoriesId'] as List,
          authorId: postData['authorId'] as int,
          title: postData['title'] as String,
          id: postData['id'] as int,
          date: (postData['date'] as Timestamp).toDate(),
          link: postData['link'] as String,
          featuredMedia: postData['featuredMedia'] as String,
          contentHtml: postData['contentHtml'] as String,
          excerptHtml: postData['excerptHtml'] as String,
        ),
      );
    });
    posts.sort((a,b)=> b.id.compareTo(a.id));
    return posts;
  }

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
          categoriesId: element['categories'],
        ),
      );
    });
    return posts;
  }

  Future<Post> getnewestPost() async {
    final posts = fromeResponsetoList(await http
        .get('https://aixformation.de/wp-json/wp/v2/posts?per_page=1&page=1'));
    return posts[0];
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
