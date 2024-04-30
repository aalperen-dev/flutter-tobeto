import 'package:firebase_intro/screens/home_screen.dart';
import 'package:firebase_intro/screens/signin_screen.dart';
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
                      listener: (context, state) {
                        if (state is SignUpSuccess) {
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
                              SignUpUser(email: _email, password: _password));
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
    );
  }
}
