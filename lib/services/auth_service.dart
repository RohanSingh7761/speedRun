// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //* Instance of firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //* sign in
  Future<UserCredential> signInWithEmail(String emailAddress, password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  //* sign up
  Future<UserCredential> signUpWithEmail(String emailAddress, password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  //* logout
  Future<void> signUserOut() async {
    await _auth.signOut();
  }
}
