import 'package:flutter/material.dart';
import 'package:meals_app/screens/sayfab.dart';

import '../widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 2,
        ),
        children: const [
          CategoryCard(),
          CategoryCard(),
          CategoryCard(),
          CategoryCard(),
          CategoryCard(),
          CategoryCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).pop();

          // // Basit bir push kullanım örneği
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const PageB(),
          //   ),
          // );

          // Basit bir pushReplacement kullanım örneği
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PageB(),
            ),
          );
        },
      ),
    );
  }
}
