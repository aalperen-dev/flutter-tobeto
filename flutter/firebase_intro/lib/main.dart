import 'package:firebase_intro/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_intro/screens/auth.dart';
import 'package:flutter/material.dart';

//TODO: https://www.freecodecamp.org/news/user-authentication-flow-in-flutter-with-firebase-and-bloc/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(),
    );
  }
}
