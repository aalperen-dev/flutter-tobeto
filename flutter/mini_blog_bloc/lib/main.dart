import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/repositories/blog_repository.dart';
import 'package:mini_blog/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/blog/blog_bloc.dart';
import 'themes/dark_theme.dart';
import 'themes/light_theme.dart';

//TODO: on'da değişken kullacağımız zaman. bu değişkeni event'damı tanımlıcaz state'demi?

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  @override
  void initState() {
    super.initState();
    _readThemeData();
  }

  _readThemeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isDark = preferences.getBool("DARKTHEME");
    if (isDark != null && isDark) {
      setState(() {
        themeMode = ThemeMode.dark;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(blogRepository: BlogRepository()),
      child: MaterialApp(
        title: 'mini blog',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: const HomePage(),
      ),
    );
  }
}
