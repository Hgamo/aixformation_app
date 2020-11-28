import 'package:aixformation_app/classes/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCategories {
  static Future<Category> getCategoryById(int id) async {
    final firestore = FirebaseFirestore.instance;
    final data = (await firestore.collection('categories').get()).docs;
    final catData =
        data.firstWhere((element) => element.data()['id'] == id).data();
    final Category category = Category(
      id: catData['id'],
      name: catData['name'],
    );
    return category;
  }
}
