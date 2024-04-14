// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mini_blog/models/blog_model.dart';
import 'package:mini_blog/screens/homepage.dart';

class BlogDetailsScreen extends StatefulWidget {
  final BlogModel blogModel;

  const BlogDetailsScreen({
    super.key,
    required this.blogModel,
  });

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

// TextEditingController baslikCont = TextEditingController();
// TextEditingController icerikCont = TextEditingController();
// TextEditingController yazarCont = TextEditingController();
// TextEditingController idCont = TextEditingController();

String yeniBaslik = '';
String yeniIcerik = '';
String yeniYazar = '';

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
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
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
  late bool selected;

  @override
  void initState() {
    super.initState();
    // baslikCont.text = widget.blogModel.title;
    // icerikCont.text = widget.blogModel.content;
    // yazarCont.text = widget.blogModel.author;
    // idCont.text = widget.blogModel.id;

    selected = false;
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
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(Icons.arrow_back),
        // ),
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // resim
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                        height: selected
                            ? MediaQuery.of(context).size.height - 200
                            : 200,
                        width: double.infinity,
                        alignment: selected
                            ? Alignment.center
                            : AlignmentDirectional.topCenter,
                        child: Image.network(
                          widget.blogModel.thumbnail,
                          fit: BoxFit.cover,

                          // scale: 2.0,
                        ),
                      ),
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
                        // controller: baslikCont,
                        onSaved: (newValue) {
                          setState(() {
                            yeniBaslik = newValue!;
                          });
                        },
                        initialValue: widget.blogModel.title,
                        decoration: const InputDecoration(
                          label: Text('Başlık - Title'),
                        ),
                      ),

                      // içerik
                      TextFormField(
                        // initialValue: widget.blogModel.content,
                        onSaved: (newValue) {
                          setState(() {
                            yeniIcerik = newValue!;
                          });
                        },
                        // controller: icerikCont,
                        minLines: 1,
                        maxLines: 5,
                        initialValue: widget.blogModel.content,
                        decoration: const InputDecoration(
                          label: Text('İçerik - Content'),
                        ),
                      ),
                      // yazar
                      TextFormField(
                        // controller: yazarCont,
                        initialValue: widget.blogModel.author,
                        onSaved: (newValue) {
                          // setState(() {
                          //   yeniYazar = newValue!;
                          // });

                          print(newValue);
                        },
                        decoration: const InputDecoration(
                          label: Text('Yazar - Author'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          // print(baslikCont.text);
                          // print(icerikCont.text);
                          // print(yazarCont.text);

                          _formKey.currentState!.save();

                          BlogModel updatedBlog = widget.blogModel.copyWith(
                            title: yeniBaslik,
                            content: yeniIcerik,
                            author: yeniYazar,
                          );

                          // if (icerikCont.text.length > 2 &&
                          //     icerikCont.text.length < 100 &&
                          //     icerikCont.text.contains('.')) {
                          //   print('doru uzunluk');
                          // } else {
                          //   print('yanlış');
                          // }

                          await _update(context, updatedBlog);
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
