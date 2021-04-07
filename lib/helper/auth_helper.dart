import 'package:aixformation_app/shared/auth_status_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './auth_state_helper.dart';

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

  static Future<AuthResultStatus> logInEandP(
      {String eMail, String password}) async {
    final _auth = FirebaseAuth.instance;
    AuthResultStatus _status;

    try {
      final methods = await _auth.fetchSignInMethodsForEmail(eMail);
      final authResult = methods.isEmpty
          ? await _auth.createUserWithEmailAndPassword(
              email: eMail, password: password)
          : await _auth.signInWithEmailAndPassword(
              email: eMail, password: password);

      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
        await Auth.newUser();
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
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
    FirebaseAnalytics().resetAnalyticsData();
    auth.currentUser.delete();
  }

  // static Future<bool> emailExists(String email) async {
  //   final auth = FirebaseAuth.instance;
  //   try {
  //     await auth.fetchSignInMethodsForEmail(email);
  //   } on Exception catch (_) {
  //     return false;
  //   }
  //   return true;
  // }
}
