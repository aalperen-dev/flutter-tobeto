import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
      ),
      body: GridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          return CategoryCard(
            name: categories[index].name,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
