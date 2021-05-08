import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  int id;
  String name;
  Category({
    this.id,
    this.name,
  });
  factory Category.fromFirebase(DocumentSnapshot<Map> snapshot) {
    final data = snapshot.data();
    return Category(
      id: data['id'],
      name: data['name'],
    );
  }
}
