import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavHelper {
  static Future<bool> isFav(int postId) async {
    final firestore = FirebaseFirestore.instance;
    User user = Auth.getAuthstae();
    final data = (await firestore.collection('fav').doc(user.uid).get()).data();
    if (data == null) {
      return false;
    }
    if (data[postId.toString()] == null) {
      return false;
    }
    return data[postId.toString()];
  }

  static changefav(int postId) async {
    final firestore = FirebaseFirestore.instance;
    User user = Auth.getAuthstae();
    if (await isFav(postId)) {
      firestore.collection('fav').doc(user.uid).set(
        {postId.toString(): false},
        SetOptions(merge: true),
      );
    } else {
      firestore.collection('fav').doc(user.uid).set(
        {postId.toString(): true},
        SetOptions(merge: true),
      );
    }
  }

  static Future<List<Post>> getonlyfavs(List<Post> posts) async{
    List<Post> favposts = [];
    posts.forEach((element) async {
      if (await FavHelper.isFav(element.id)) {
        favposts.add(element);
      }
    });
    return favposts;
  }
}