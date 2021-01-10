import 'package:aixformation_app/classes/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCategories {
  Stream<List<Category>> categories = FirebaseFirestore.instance
      .collection('categories')
      .snapshots()
      .map((event) => event.docs.map((e) => Category.fromFirebase(e)).toList());
}
