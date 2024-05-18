import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/repositories/blog_repository.dart';
import 'package:mini_blog/screens/blog_details_screen.dart';
import 'package:mini_blog/screens/edit_screen.dart';
import 'package:mini_blog/screens/homepage.dart';
import 'package:mini_blog/simple_bloc_obs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/blog/blog_bloc.dart';
import 'themes/dark_theme.dart';
import 'themes/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

//TODO: https://www.youtube.com/watch?v=laqnY0NjU3M

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

  final BlogBloc _blogBloc = BlogBloc(blogRepository: BlogRepository());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mini blog',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routes: {
        '/': (context) => BlocProvider.value(
              value: _blogBloc,
              child: const HomePage(),
            ),
        'edit': (context) => BlocProvider.value(
              value: _blogBloc,
              child: const EditScreen(),
            ),
        'details': (context) => BlocProvider.value(
              value: _blogBloc,
              child: const BlogDetailsScreen(),
            ),
      },
      // home: const HomePage(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _blogBloc.close();
  }
}
