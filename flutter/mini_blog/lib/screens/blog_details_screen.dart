// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mini_blog/models/blog_model.dart';
import 'package:http/http.dart' as http;

class BlogDetailsScreen extends StatefulWidget {
  final BlogModel blogModel;
  const BlogDetailsScreen({
    super.key,
    required this.blogModel,
  });

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

TextEditingController baslikCont = TextEditingController();
TextEditingController icerikCont = TextEditingController();
TextEditingController yazarCont = TextEditingController();

Future<void> _update(
  BuildContext context,
  BlogModel blogModel,
) async {
  Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/");

  http.Response response = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // body: convert.jsonEncode(<String, String>{
    //   'id': blogModel.id,
    //   'Title': blogModel.title,
    //   'Content': blogModel.content,
    //   'thumbnail': blogModel.thumbnail,
    //   'Author': blogModel.author,
    // }),
    body: blogModel.toJson(),
  );

  if (response.statusCode == 200) {
    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post Güncellendi!'),
        ),
      );
    }
  } else {
    print('hata kodu : ${response.statusCode}');
  }
}

Future<void> _deletePost(
  BuildContext context,
  String postId,
) async {
  Uri url =
      Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$postId");

  http.Response response = await http.delete(url);

  if (response.statusCode == 200) {
    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post Silindi!'),
        ),
      );
    }
  } else {
    print('hata kodu : ${response.statusCode}');
  }
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  void initState() {
    super.initState();
    baslikCont.text = widget.blogModel.title;
    icerikCont.text = widget.blogModel.content;
    yazarCont.text = widget.blogModel.author;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   baslikCont.dispose();
  //   icerikCont.dispose();
  //   yazarCont.dispose();
  // }

  bool editMode = true;
  final _formKey = GlobalKey<FormState>();

  // String blogTitle = '';
  // String blogContent = '';
  // String author = '';
  // XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                editMode = !editMode;
              });
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () async {
              _deletePost(
                context,
                widget.blogModel.id,
              );
            },
            icon: const Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),
      body: editMode
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // resim
                    Image.network(
                      widget.blogModel.thumbnail,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width - 200,
                    ),
                    // başlık
                    Text(
                      widget.blogModel.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    // yazar
                    Text(
                      widget.blogModel.author,
                      textAlign: TextAlign.center,
                    ),
                    // içerik
                    Text(
                      widget.blogModel.content,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Form(
                  key: _formKey, //key verilmesi şart
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      SizedBox(
                        // height: MediaQuery.of(context).size.width - 200,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Image.network(
                              widget.blogModel.thumbnail,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.mode_edit_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // başlık
                      TextFormField(
                        controller: baslikCont,
                        // initialValue: widget.blogModel.title,
                        decoration: const InputDecoration(
                          label: Text('Başlık - Title'),
                        ),
                      ),
                      // içerik
                      TextFormField(
                        controller: icerikCont,
                        minLines: 1,
                        maxLines: 5,
                        // initialValue: widget.blogModel.content,
                        decoration: const InputDecoration(
                          label: Text('İçerik - Content'),
                        ),
                      ),
                      // yazar
                      TextFormField(
                        controller: yazarCont,
                        // initialValue: widget.blogModel.author,
                        decoration: const InputDecoration(
                          label: Text('Yazar - Author'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          print(baslikCont.text);
                          print(icerikCont.text);
                          print(yazarCont.text);

                          BlogModel deneme = widget.blogModel.copyWith(
                            title: baslikCont.text,
                            content: icerikCont.text,
                            author: yazarCont.text,
                          );

                          await _update(context, deneme);
                        },
                        child: const Text('Güncelle!'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
