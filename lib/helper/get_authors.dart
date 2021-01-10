import 'package:aixformation_app/classes/author.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAuthors {
  Stream<List<Author>> authors = FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((event) => event.docs.map((e) => Author.formFirebase(e)).toList());
}
