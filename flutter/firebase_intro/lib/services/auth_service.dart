// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign up
  Future<String> signUpUser(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        return firebaseUser.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
    }
    return '';
  }

  Future<void> signInUser(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
    }
  }

  //  log out
  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
}
