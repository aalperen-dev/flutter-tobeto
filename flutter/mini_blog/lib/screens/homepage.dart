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
  final List<BlogModel> dataFromApi = [];
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

  // Future<void> _getPosts() async {
  //   Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

  //   http.Response response = await http.get(url);

  //   List? jsonReponse;

  //   if (response.statusCode == 200) {
  //     jsonReponse = convert.jsonDecode(response.body);
  //     print(jsonReponse);
  //   } else {
  //     print('hata kodu : ${response.statusCode}');
  //   }

  //   for (var element in jsonReponse!) {
  //     dataFromApi.add(BlogModel.fromMap(element));
  //   }
  // }

  Future<List<BlogModel>> _getRequest() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    http.Response response = await http.get(url);

    List? jsonResponse;
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
    } else {
      print('hata kodu : ${response.statusCode}');
    }

    for (var element in jsonResponse!) {
      dataFromApi.add(BlogModel.fromMap(element));
    }

    return dataFromApi;
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ListTile(
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
                      Text(snapshot.data![index].content!),
                    ],
                  ),
                ),
              );
            }
          },
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
