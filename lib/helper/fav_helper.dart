import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavHelper {
  static Future<bool> isFav(int postId) async {
    final firestore = FirebaseFirestore.instance;
    final User user = Auth.getAuthstate();
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
    User user = Auth.getAuthstate();
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

  static Stream<List<int>> get getFavsIds {
    final firestore = FirebaseFirestore.instance;
    final User user = Auth.getAuthstate();
    return firestore
        .collection('fav')
        .doc(user.uid)
        .snapshots()
        .map(favIntsFromDocument);
  }

  static List<int> favIntsFromDocument(DocumentSnapshot snapshot) {
    List<int> favints = [];
    final data = snapshot.data();
    data.forEach((key, value) {
      if (value as bool) {
        favints.add(int.parse(key));
      }
    });
    return favints;
  }
}
