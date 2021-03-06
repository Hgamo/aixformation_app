import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aixformation_app/classes/class_post.dart';

class GetPosts {
  static Stream<List<Post>> getPosts() {
    final firestore = FirebaseFirestore.instance;
    return firestore
        .collection('posts')
        .orderBy('date', descending: true)
        .limit(20)
        .snapshots()
        .map(fromSnapshotToList);
  }

  static List<Post> fromSnapshotToList(QuerySnapshot<Map> snapshot) {
    List<Post> posts = [];
    snapshot.docs.forEach((element) {
      final postData = element.data();

      posts.add(
        Post(
          categoriesId: List<int>.from(postData['categoriesId']),
          authorId: postData['authorId'],
          title: postData['title'],
          id: postData['id'],
          date: (postData['date']).toDate(),
          link: postData['link'],
          featuredMedia: postData['featuredMedia'],
          contentHtml: postData['contentHtml'],
          excerptHtml: postData['excerptHtml'],
        ),
      );
    });
    return posts;
  }

  static Future<Post> getPostById(int postId) async {
    final firestore = FirebaseFirestore.instance;
    final posts = fromSnapshotToList(await firestore
        .collection('posts')
        .where('id', isEqualTo: postId)
        .get());
    return posts[0];
  }
}
