import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddBlog'),
      ),
      body: Form(
        key: _formKey, //key verilmesi şart
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Baslık'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'başlık boş  olamaz';
                }
                return null;
              },
              onSaved: (newValue) {
                print(newValue);
                blogTitle = newValue!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('içerik'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'içerik olamaz';
                }
                return null;
              },
              onSaved: (newValue) {
                print(newValue);
                blogContent = newValue!;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: const Text('text'),
            ),
          ],
        ),
      ),
    );
  }
}
