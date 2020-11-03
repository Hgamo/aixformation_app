import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/helper/get_posts.dart';

class GetData {
  Future<Map<String, dynamic>> getallData() async {
    Map<String, dynamic> data = {
      'posts': await GetPosts().getPosts(),
      'categories': await GetCategories().getallcategories(),
      'authors': await GetPosts().getallauthors(),
    };
    return data;
  }
}
