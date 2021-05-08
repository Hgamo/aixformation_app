import 'package:cloud_firestore/cloud_firestore.dart';

class Author {
  String name;
  int id;
  String description;
  String avatarUrl;
  Author({
    this.id,
    this.name,
    this.description,
    this.avatarUrl,
  });

  factory Author.formFirebase(DocumentSnapshot<Map> snapshot) {
    return Author(
      id: snapshot.data()['id'],
      name: snapshot.data()['name'],
      description: snapshot.data()['description'],
      avatarUrl: snapshot.data()['avatar_url'],
    );
  }
}
