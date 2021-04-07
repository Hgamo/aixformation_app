import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:aixformation_app/helper/json_helper.dart';

class AppStart {
  static Future onAppStrat() async {
    final firestore = FirebaseFirestore.instance;

    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      //Die App ist nicht online
      return;
    }
    final idData = await firestore.collection('main').doc('posts').get();
    final int newestFirestoreId = idData.data()['newPost'];
    if (await JsonHelper.isnewestPost(newestFirestoreId)) {
      //Der neuste Post ist schon auf Firebase
      print('Der neuste Post ist schon auf Firebase');
      return;
    } else {
      if (await JsonHelper.issecondnewestPost(newestFirestoreId)) {
        //Der zweit neuste Post ist schon auf Firebase
        //Der neuste Artikel muss Hochgeladen werden
        print('Der zweit neuste Post ist schon auf Firebase');
        print('Der neuste Artikel muss Hochgeladen werden');
        final newestPost = await JsonHelper.getnewestPost();
        firestore.collection('posts').add({
          'categoriesId': newestPost.categoriesId,
          'authorId': newestPost.authorId,
          'title': newestPost.title,
          'id': newestPost.id,
          'date': newestPost.date,
          'link': newestPost.link,
          'featuredMedia': newestPost.featuredMedia,
          'contentHtml': newestPost.contentHtml,
          'excerptHtml': newestPost.excerptHtml,
        });
        setnewestPost(newestPost.id);
      } else {
        //keine Ahnug, was passiert ist alle Artikel werden ersetzt
        print('keine Ahnug, was passiert ist alle Artikel werden ersetzt');
        final allPosts = await JsonHelper.getPosts();
        allPosts.forEach((e) {
          firestore.collection('posts').add({
            'categoriesId': e.categoriesId,
            'authorId': e.authorId,
            'title': e.title,
            'id': e.id,
            'date': e.date,
            'link': e.link,
            'featuredMedia': e.featuredMedia,
            'contentHtml': e.contentHtml,
            'excerptHtml': e.excerptHtml,
          });
        });
        setnewestPost(allPosts[0].id);
        return;
      }
    }
  }

  static setnewestPost(int id) {
    final firestore = FirebaseFirestore.instance;
    firestore.collection('main').doc('posts').set({
      'newPost': id,
    });
  }
}
