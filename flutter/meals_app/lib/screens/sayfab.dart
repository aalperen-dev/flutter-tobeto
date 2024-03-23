import 'package:flutter/material.dart';
import 'package:meals_app/screens/sayfac.dart';

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('B'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const PageC(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
