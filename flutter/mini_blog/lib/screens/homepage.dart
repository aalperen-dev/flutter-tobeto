import 'package:flutter/material.dart';
import 'package:mini_blog/models/blog_model.dart';
import 'package:mini_blog/screens/add_blog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeMode themeMode = ThemeMode.light;

  // void _changeTheme(bool value) {
  //   setState(() {
  //     themeMode = value ? ThemeMode.dark : ThemeMode.light;
  //     _writeThemeData(value);
  //   });
  // }

  // void _writeThemeData(bool value) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool('DarkTheme', value);
  // }

  final List<BlogModel> dataFromApi = [];

  Future<void> _getPosts() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    http.Response response = await http.get(url);

    List? jsonReponse;

    if (response.statusCode == 200) {
      jsonReponse = convert.jsonDecode(response.body);
      print(jsonReponse);
    } else {
      print('hata kodu : ${response.statusCode}');
    }

    for (var element in jsonReponse!) {
      dataFromApi.add(BlogModel.fromMap(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddBlogScreen(),
              ));
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: dataFromApi.isEmpty
          ? const Center(
              child: Text('Data Yok!'),
            )
          : ListView.builder(
              itemCount: dataFromApi.length,
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(
                  dataFromApi[index].thumbnail!,
                  width: 50,
                ),
                title: Text(dataFromApi[index].title!),
                subtitle: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dataFromApi[index].author!),
                    Text(dataFromApi[index].content!),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _getPosts();
          setState(() {});
          print('deneme ${dataFromApi[0]}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
