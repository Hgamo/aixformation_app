import 'dart:convert';
import 'package:aixformation_app/classes/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class GetCategories {
  Future<List<Category>> getFireCategories() async {
    final firestore = FirebaseFirestore.instance;
    final data = (await firestore.collection('categories').get()).docs;
    List<Category> categories = [];
    data.forEach((element) {
      final e = element.data();
      categories.add(Category(
        id: e['id'],
        name: e['name'],
      ));
    });
    return categories;
  }

  Future<List<Category>> getallcategories() async {
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
    return possiblecategories;
  }

  void upoadCategories() async {
    final categories = await getallcategories();
    final firestore = FirebaseFirestore.instance;
    categories.forEach((element) {
      firestore.collection('categories').add({
        'id': element.id,
        'name': element.name,
      });
    });
  }
}
