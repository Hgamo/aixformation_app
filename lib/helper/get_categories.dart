import 'dart:convert';
import 'package:aixformation_app/classes/category.dart';
import 'package:http/http.dart' as http;

class GetCategories {
  List categories;
  GetCategories(this.categories);

  Future<List<String>> getCategoriesById() async {
    final response = await http
        .get('https://aixformation.de/wp-json/wp/v2/categories?per_page=100');
    final List data = jsonDecode(response.body);

    List<Category> possiblecategories = [];
    data.forEach((element) {
      possiblecategories.add(Category(
        id: element['id'],
        name: element['name'],
      ));
    });
    List<String> returncategories = [];
    possiblecategories.forEach((element) {
      if (categories.contains(element.id)) {
        returncategories.add(element.name);
      }
    });
    return returncategories;
  }
}
