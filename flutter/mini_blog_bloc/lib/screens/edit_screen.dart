import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mini_blog/models/blog_model.dart';
import 'package:mini_blog/screens/blog_details_screen.dart';
import 'package:mini_blog/screens/homepage.dart';

import '../bloc/blog/blog_bloc.dart';

class EditScreen extends StatefulWidget {
  final BlogModel blogModel;
  const EditScreen({
    super.key,
    required this.blogModel,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

// form key
final _formKey = GlobalKey<FormState>();

// güncelleme - form'da on saved kullanarak
String newTitle = '';
String newContent = '';
String newAuthor = '';

// güncelleme - controller kullanarak
// late TextEditingController titleController;
// late TextEditingController contentController;
// late TextEditingController authorController;

// güncelleme fonksiyonu
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
    body: blogModel.toJson(),
  );

  if (response.statusCode == 200) {
    if (kDebugMode) {
      print('Başarılı!!!');
    }
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
    if (kDebugMode) {
      print('Hata Kodu : ${response.statusCode}');
    }
  }
}

class _EditScreenState extends State<EditScreen> {
  // init controller için lazım
  // @override
  // void initState() {
  //   titleController = TextEditingController();
  //   contentController = TextEditingController();
  //   authorController = TextEditingController();

  //   super.initState();

  //   titleController.text = widget.blogModel.title;
  //   contentController.text = widget.blogModel.content;
  //   authorController.text = widget.blogModel.author;
  // }

  // controller dispose
  // @override
  // void dispose() {
  //   super.dispose();
  //   titleController.dispose();
  //   contentController.dispose();
  //   authorController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlogBloc, BlogState>(
      listener: (context, state) async {
        if (state is UpdateBlogSuccess && context.mounted) {
          context.read<BlogBloc>().add(FetchAllBlogs());

          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  BlogDetailsScreen(blogModel: widget.blogModel),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit Blog'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey, //key verilmesi şart
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // resim
                  SizedBox(
                    height: 200,
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

                  // başlık - title
                  TextFormField(
                    // güncelleme controller ile
                    // controller: titleController,

                    // güncelleme - onsaved ile
                    initialValue: widget.blogModel.title,
                    onSaved: (newValue) {
                      newTitle = newValue!;
                    },
                    decoration: const InputDecoration(
                      label: Text('Başlık - Title'),
                    ),
                  ),

                  // içerik
                  TextFormField(
                    // güncelleme controller ile
                    // controller: contentController,

                    // güncelleme - onsaved ile
                    initialValue: widget.blogModel.content,
                    onSaved: (newValue) {
                      newContent = newValue!;
                    },
                    decoration: const InputDecoration(
                      label: Text('İçerik - Content'),
                    ),
                  ),

                  // yazar
                  TextFormField(
                    // güncelleme controller ile
                    // controller: authorController,

                    // güncelleme - onsaved ile
                    initialValue: widget.blogModel.author,
                    onSaved: (newValue) {
                      newAuthor = newValue!;
                    },
                    decoration: const InputDecoration(
                      label: Text('Yazar - Author'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      // güncelleme - onsaved ile
                      _formKey.currentState!.save();

                      BlogModel updatedBlog = widget.blogModel.copyWith(
                        title: newTitle,
                        content: newContent,
                        author: newAuthor,
                      );

                      // güncelleme - controller ile
                      // BlogModel updatedBlog = widget.blogModel.copyWith(
                      //   title: titleController.text,
                      //   content: contentController.text,
                      //   author: authorController.text,
                      // );

                      context
                          .read<BlogBloc>()
                          .add(UpdateBlog(blogModel: updatedBlog));
                    },
                    child: const Text('Güncelle!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
