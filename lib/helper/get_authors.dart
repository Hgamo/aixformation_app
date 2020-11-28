import 'package:cloud_firestore/cloud_firestore.dart';

class GetAuthors {
  static Future<String> getAuthorNameById(int authorId) async {
    final firestore = FirebaseFirestore.instance;
    final data = (await firestore.collection('users').get()).docs;
    return data
            .firstWhere((element) => element.data()['id'] == authorId)
            .data()['name'] ??
        '';
  }
}
