import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  bool _registerPage = true;

  void _submit({
    required String email,
    required String password,
  }) async {
    _registerPage
        ? _register(email: email, password: password)
        : _login(context, email: email, password: password);
  }

  void _login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? "Giriş Başarısız"),
          ),
        );
      }
    }
  }

  void _register({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          print('Şifre minimum 6 karakter olmalıdır!');
          break;
        case 'invalid-email':
          print('Geçeli bir e-posta adresi giriniz!');
          break;
        default:
          print(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    Text(_registerPage ? 'Kayıt ol!' : 'Giriş Yap!'),
                    const SizedBox(height: 15),
                    // email
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-Posta girin',
                      ),
                      onSaved: (newValue) {
                        _email = newValue!;
                      },
                    ),
                    const SizedBox(height: 15),
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
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.save();

                        _submit(
                          email: _email,
                          password: _password,
                        );
                      },
                      child: Text(
                        _registerPage ? "Kayıt Ol!" : 'Giriş Yap!',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _registerPage = !_registerPage;
                        });
                      },
                      child: Text(
                        _registerPage
                            ? "Zaten üye misiniz? Giriş yapın."
                            : 'Hesabınız yok mu? Kayıt olun.',
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
