// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  // key tanımlama
  final _formKey = GlobalKey<FormState>();

  //
  String blogTitle = '';
  String blogContent = '';
  String author = '';
  XFile? selectedImage;

  //
  Future<void> _submit(BuildContext context) async {
    print(blogTitle);
    print(blogContent);

    if (selectedImage != null) {
      Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

      var request = http.MultipartRequest('POST', url);
      // içerik ekleme
      request.fields['Title'] = blogTitle;
      request.fields['Content'] = blogContent;
      request.fields['Author'] = author;

      // dosya ekleme
      final file =
          await http.MultipartFile.fromPath('File', selectedImage!.path);
      request.files.add(file);

      // gönderme
      final response = await request.send();

      if (response.statusCode == 201) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
      }

      // http.Response response = await http.post(url);
    }
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(
      source: ImageSource.camera,
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
                    print(newValue);
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
                    print(newValue);
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
                    print(newValue);
                    author = newValue!;
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
    );
  }
}
