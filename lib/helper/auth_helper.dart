import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static User getAuthstate() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return user;
  }

  static newUser() async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('fav').doc(Auth.getAuthstate().uid).set(
      {},
      SetOptions(merge: true),
    );
  }

  static logInAny() async {
    await FirebaseAuth.instance.signInAnonymously();
    await Auth.newUser();
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
  }

  static logInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      // cancelled login
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential);
    await Auth.newUser();
  }

  static deleteForever() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('fav').doc(Auth.getAuthstate().uid).delete();
    auth.currentUser.delete();
  }

  static Future<bool> emailExists(String email) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.fetchSignInMethodsForEmail(email);
    } on Exception catch (_) {
      return false;
    }
    return true;
  }
}
