// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_intro/models/user_model.dart';
import 'package:firebase_intro/screens/home_screen.dart';
import 'package:firebase_intro/screens/signin_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKeySignUp = GlobalKey<FormState>();
  String _email = '';
  String _name = '';
  String _lastname = '';
  String _password = '';
  // resim
  File? selectedImage;

  Future<FilePickerResult?> _pickImage() async {
    final image = await FilePicker.platform.pickFiles(type: FileType.any);

    return image;
  }

  Future<void> _selectImage() async {
    final res = await _pickImage();

    if (res != null) {
      setState(() {
        selectedImage = File(res.files.first.path!);
      });
    }
  }

  Future<String> _uploadTest(File image) async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref('resimler').child(DateTime.now().toString());
    UploadTask uploadTask;
    uploadTask = storageRef.putFile(
      image,
      SettableMetadata(contentType: 'image/jpg'),
    );
    final snapshot = await uploadTask;
    final photoUrl = snapshot.ref.getDownloadURL();

    return photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            child: Form(
              key: _formKeySignUp,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    const Text('Kayıt ol!'),
                    const SizedBox(height: 15),
                    // resim
                    if (selectedImage != null)
                      Image.file(
                        selectedImage!,
                        height: 100,
                      ),
                    ElevatedButton(
                      onPressed: () async {
                        await _selectImage();
                      },
                      child: const Text(
                        "Foto Seç",
                      ),
                    ),

                    // email
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-posta girin',
                      ),
                      onSaved: (newValue) {
                        _email = newValue!;
                      },
                    ),
                    // name
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'İsim girin',
                      ),
                      onSaved: (newValue) {
                        _name = newValue!;
                      },
                    ),
                    // lastname
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Soyisim girin',
                      ),
                      onSaved: (newValue) {
                        _lastname = newValue!;
                      },
                    ),
                    // password
                    TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Şifre belirleyin.',
                      ),
                      onSaved: (newValue) {
                        _password = newValue!;
                      },
                    ),
                    const SizedBox(height: 15),
                    // login - register butonu
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) async {
                        if (state is SignUpSuccess) {
                          FirebaseFirestore db = FirebaseFirestore.instance;
                          String photoUrl = await _uploadTest(selectedImage!);

                          UserModel userModel = UserModel(
                            uid: state.uid,
                            email: _email,
                            firstName: _name,
                            lastName: _lastname,
                            photoUrl: photoUrl,
                          );

                          await db
                              .collection('users')
                              .doc(state.uid)
                              .set(userModel.toMap());

                          if (!context.mounted) return;
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false);
                        }
                        if (state is SignUpFailure) {}
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          _formKeySignUp.currentState!.save();

                          context.read<AuthBloc>().add(
                                SignUpUser(email: _email, password: _password),
                              );
                        },
                        child: const Text(
                          "Kayıt Ol!",
                        ),
                      ),
                    ),
                    // değiştime butonu
                    const SizedBox(height: 15),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ));
                      },
                      child: const Text(
                        "Zaten üye misiniz? Giriş yapın.",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String photoUrl = await _uploadTest(selectedImage!);
          print(photoUrl);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
