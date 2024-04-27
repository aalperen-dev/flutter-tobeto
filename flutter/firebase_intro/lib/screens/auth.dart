import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intro/screens/home_screen.dart';
import 'package:firebase_intro/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // void _submit({
  //   required String email,
  //   required String password,
  // }) async {
  //   _registerPage
  //       ? _register(email: email, password: password)
  //       : _login(context, email: email, password: password);
  // }

  // void _login(
  //   BuildContext context, {
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: _email, password: _password);
  //   } on FirebaseAuthException catch (error) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(error.message ?? "Giriş Başarısız"),
  //         ),
  //       );
  //     }
  //   }
  // }

  // void _register({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     switch (e.code) {
  //       case 'weak-password':
  //         print('Şifre minimum 6 karakter olmalıdır!');
  //         break;
  //       case 'invalid-email':
  //         print('Geçeli bir e-posta adresi giriniz!');
  //         break;
  //       default:
  //         print(e.code);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
