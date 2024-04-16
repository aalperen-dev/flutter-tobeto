import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mini_blog/models/blog_model.dart';
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

  Future<void> _submit(BuildContext context) async {
    if (selectedImage != null) {
      Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

      var request = http.MultipartRequest('POST', url);
      // içerik ekleme
      request.fields['Title'] = blogTitle;
      request.fields['Content'] = blogContent;
      request.fields['Author'] = blogAuthor;

      // dosya ekleme
      final file =
          await http.MultipartFile.fromPath('File', selectedImage!.path);
      request.files.add(file);

      // gönderme
      final response = await request.send();

      if (response.statusCode == 201) {
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    }
  }

  // 400 hatası veriyor. request body türü yok.
  Future<void> _submitTest(
    BuildContext context,
    BlogModel blogModel,
  ) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    http.Response response = await http.post(
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
    return Scaffold(
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
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                    _submit(context);
                  },
                  child: const Text('Kaydet'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // deneme
          if (selectedImage != null) {
            BlogModel postTest = BlogModel(
              title: blogTitle,
              content: blogContent,
              thumbnail: selectedImage!.path,
              author: blogAuthor,
            );

            await _submitTest(context, postTest);
          }
        },
        child: const Icon(Icons.warning),
      ),
    );
  }
}
