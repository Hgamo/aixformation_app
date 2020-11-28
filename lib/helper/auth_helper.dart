import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  loginAn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInAnonymously();
  }

  User getAuthstate() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return user;
  }

  logout() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }

}
