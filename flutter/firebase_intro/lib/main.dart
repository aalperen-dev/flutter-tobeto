import 'package:firebase_intro/alperen_blog/blog_card.dart';
import 'package:firebase_intro/alperen_blog/blog_details_screen.dart';
import 'package:firebase_intro/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_intro/proje_test/goruntule_ekran.dart';
import 'package:firebase_intro/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth_bloc/auth_bloc.dart';

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
    return BlocProvider(
      create: (context) => AuthBloc(authService: AuthService()),
      child: MaterialApp(
        title: 'Firebase',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TakvimEkrani(),
      ),
    );
  }
}
