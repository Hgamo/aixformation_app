import 'package:cloud_firestore/cloud_firestore.dart';

class Author {
  String name;
  int id;
  Author({this.id, this.name});
  
  factory Author.formFirebase(DocumentSnapshot snapshot) {
    return Author(
      id: snapshot.data()['id'],
      name: snapshot.data()['name'],
    );
  }
}
