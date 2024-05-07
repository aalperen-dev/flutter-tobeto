import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intro/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<UserModel> _getUser() async {
    User? loggedInUser = FirebaseAuth.instance.currentUser;

    if (loggedInUser != null) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var userInfo = await firebaseFirestore
          .collection('users')
          .doc(loggedInUser.uid)
          .get();

      UserModel userModel = UserModel.fromMap(userInfo.data()!);

      return userModel;
    }
    throw Exception('hata');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana sayfa'),
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignOutUserSuccess) {
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //       builder: (context) => const AuthScreen(),
                //     ),
                //     (route) => false);
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
      body: FutureBuilder(
        future: _getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(snapshot.data!.photoUrl!),
                  radius: 30,
                ),
                Text('${snapshot.data!.firstName}'),
              ],
            );
          } else {
            return const Center(
              child: Text('Hata'),
            );
          }
        },
      ),
    );
  }
}
