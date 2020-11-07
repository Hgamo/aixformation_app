import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetData {
  Future<Map<String, dynamic>> getallData() async {
    final firestore = FirebaseFirestore.instance;
    if (Auth.getAuthstae() == null) {
      await Auth.loginAn();
      print('Log in An');
    }
    await firestore.collection('fav').doc(Auth.getAuthstae().uid).set(
      {},
      SetOptions(merge: true),
    );
    Map<String, dynamic> data = {
      'posts': await GetPosts.getFirebasePosts(),
      'categories': await GetCategories().getFireCategories(),
      'authors': await GetPosts().getFireAuthors(),
    };
    return data;
  }
}
