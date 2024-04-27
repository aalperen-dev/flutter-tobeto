import 'package:firebase_intro/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana sayfa'),
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignOutUserSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                    (route) => false);
              } else if (state is SignOutUserFailure) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text('Çıkış Başarısız!'),
                    );
                  },
                );
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutUser());
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Login başarılı'),
      ),
    );
  }
}
