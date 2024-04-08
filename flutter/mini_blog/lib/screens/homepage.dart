import 'package:flutter/material.dart';
import 'package:mini_blog/models/blog_model.dart';
import 'package:mini_blog/screens/add_blog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mini_blog/screens/blog_details_screen.dart';

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

  late Future<List<BlogModel>> dataFromApi;

  @override
  void initState() {
    super.initState();

    dataFromApi = _getRequest();
  }

  Future<List<BlogModel>> _getRequest() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse.map((e) => BlogModel.fromMap(e)).toList();
    } else {
      print('hata kodu : ${response.statusCode}');
      throw Exception('hata!');
    }

    // for (var element in jsonResponse!) {
    //   dataFromApi.add(BlogModel.fromMap(element));
    // }

    // return dataFromApi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddBlogScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RefreshIndicator(
          onRefresh: () {
            setState(() {});
            return _getRequest();
          },
          child: FutureBuilder(
            future: _getRequest(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // print(snapshot.data);
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlogDetailsScreen(
                              blogModel: snapshot.data![index]),
                        ),
                      );
                    },
                    leading: Image.network(
                      snapshot.data![index].thumbnail!,
                      width: 50,
                    ),
                    title: Text(snapshot.data![index].title!),
                    subtitle: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data![index].author!),
                        Text(
                          snapshot.data![index].content!,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      // ListView.builder(
      //   itemCount: dataFromApi.length,
      //   itemBuilder: (context, index) => ListTile(
      //     leading: Image.network(
      //       dataFromApi[index].thumbnail!,
      //       width: 50,
      //     ),
      //     title: Text(dataFromApi[index].title!),
      //     subtitle: Column(
      //       // mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(dataFromApi[index].author!),
      //         Text(dataFromApi[index].content!),
      //       ],
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await _getPosts();
          // setState(() {});
          // print('deneme ${dataFromApi[0]}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
