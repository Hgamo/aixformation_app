import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static loginAn() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInAnonymously();
  }

  static User getAuthstae() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return user;
  }

  static logout() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }
}
