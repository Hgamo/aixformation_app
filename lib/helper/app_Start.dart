import 'package:aixformation_app/helper/db_articles.dart';
import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

class AppStart {
  static void onAppStrat() async {
    final firestore = FirebaseFirestore.instance;
    

    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      //Die App ist nicht online
      print('Die App ist nicht online');
      return;
    }
    final idData = await firestore.collection('main').doc('posts').get();
    final int newestFirestoreId = idData.data()['newPost'];
    if (await DBArticles.isnewestPost(newestFirestoreId)) {
      //Der neuste Post ist schon auf Firebase
      print('Der neuste Post ist schon auf Firebase');
      return;
    } else {
      if (await DBArticles.issecondPost(newestFirestoreId)) {
        //Der zweit neuste Post ist schon auf Firebase
        //Der neuste Artikel muss Hochgeladen werden
        print('Der zweit neuste Post ist schon auf Firebase');
        print('Der neuste Artikel muss Hochgeladen werden');
        final newestPost = await GetPosts().getnewestPost();
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
        final allPosts = await GetPosts().getPosts();
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
    final data = await firestore.collection('main').doc('posts').get();
    if (data.data()['changed']) {
      GetPosts().upoadAuthors();
      GetCategories().upoadCategories();
    }
  }

  static setnewestPost(int id) {
    final firestore = FirebaseFirestore.instance;
    firestore.collection('main').doc('posts').set({
      'newPost': id,
    });
  }
}
