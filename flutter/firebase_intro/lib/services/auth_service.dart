import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intro/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign up
  Future<UserModel?> signUpUser(
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
        return UserModel(
            uid: firebaseUser.uid, email: firebaseUser.email ?? '');
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
    return null;
  }

  //  log out
  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
}
