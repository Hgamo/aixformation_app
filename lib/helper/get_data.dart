import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/helper/get_posts.dart';

class GetData {
  Future<Map<String, dynamic>> getallData() async {
    Map<String, dynamic> data = {
      'posts': await GetPosts.getFirebasePosts(),
      'categories': await GetCategories().getFireCategories(),
      'authors': await GetPosts().getFireAuthors(),
    };
    return data;
  }
}
