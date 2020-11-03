import 'package:aixformation_app/classes/class_post.dart';
import 'package:sqflite/sqflite.dart';

class DBArticles {
  storePost(Post post) async {
    Database db = await openDatabase('posts');
    db.insert(post.id.toString(), {
      'contentHtml': post.contentHtml,
      'featuredMedia': post.featuredMedia,
      'title': post.title,
      'excerptHtml': post.excerptHtml,
      'id': post.id,
      'date': post.date,
      'link': post.link,
      'author': post.author,
      'categories': post.categories,
    });
  }
}
