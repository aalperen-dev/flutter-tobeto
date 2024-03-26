import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.yellow,
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: theme,
      home: const CategoriesScreen(),
    );
  }
}
