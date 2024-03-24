import 'package:flutter/material.dart';
import 'package:mealsapp/models/category.dart';
import 'package:mealsapp/widgets/category_card.dart';

import '../data/category_data.dart';

// Global State - Global State Management
class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    // Kategoriler model olarak data dosyasından gelmeli.
    return Scaffold(
      appBar: AppBar(title: const Text("Kategoriler")),
      // Inkwell, GestureDetector
      body: Column(
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.5,
          //   child: GridView(
          //       padding: const EdgeInsets.all(8),
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           crossAxisSpacing: 25,
          //           mainAxisSpacing: 5,
          //           childAspectRatio: 4 / 2),
          //       children:
          //           categories.map((e) => CategoryCard(category: e)).toList()),
          // ),

          CategoryCard(
            category: categories[1],
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CatGuidTest denme = CatGuidTest(name: 'name', surname: 'surname');
          print(denme.id);

          print(DateTime.now().microsecondsSinceEpoch);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
