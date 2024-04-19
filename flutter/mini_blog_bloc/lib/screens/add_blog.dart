import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_blog/bloc/blog/blog_bloc.dart';
import 'package:mini_blog/screens/homepage.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  // key tanımlama
  final _formKey = GlobalKey<FormState>();

  // değişkenler
  String blogTitle = '';
  String blogContent = '';
  String blogAuthor = '';
  XFile? selectedImage;

  // resim seçme
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      selectedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlogBloc, BlogState>(
      listener: (context, state) async {
        if (state is AddBlogSuccess && context.mounted) {
          context.read<BlogBloc>().add(FetchAllBlogs());

          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        }
        if (state is AddBlogFailed && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ekleme Hatalı'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AddBlog'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              key: _formKey, //key verilmesi şart
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _pickImage();
                    },
                    child: const Text(
                      "Foto Seç",
                    ),
                  ),
                  //
                  if (selectedImage != null)
                    Image.file(
                      height: 200,
                      File(selectedImage!.path),
                    ),
                  // başlık
                  TextFormField(
                    // controller: controller,
                    decoration: const InputDecoration(
                      label: Text('Başlık - Title'),
                    ),
                    validator: (value) {
                      //alanların şartlara uyup uymadığını kontrol eder
                      if (value == null || value.isEmpty) {
                        return 'Alan Boş Bırakılamaz!';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      // print(newValue);
                      blogTitle = newValue!;
                    },
                  ),
                  // içerik
                  TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      label: Text('İçerik - Content'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alan Boş Bırakılamaz!';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      // print(newValue);
                      blogContent = newValue!;
                    },
                  ),
                  // yazar
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Yazar - Author'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alan Boş Bırakılamaz!';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      // print(newValue);
                      blogAuthor = newValue!;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedImage != null) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }

                        context.read<BlogBloc>().add(
                              AddBlog(
                                  blogTitle: blogTitle,
                                  blogContent: blogContent,
                                  blogAuthor: blogAuthor,
                                  imagePath: selectedImage!.path),
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Resim Seçmediniz'),
                          ),
                        );
                      }

                      // _submit(context);
                    },
                    child: const Text('Kaydet'),
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
