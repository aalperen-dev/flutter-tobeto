// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:mealsapp/models/category.dart';

class CategoryCard extends StatelessWidget {
  final VoidCallback onTap;
  final Category category;
  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  // Dışarıdan alınan kategori modeli rengi ve ismi ile bu kartta kullanılmalı.
  // onTap aksiyonu, dışardan aldığı fonksiyonu haberdar etmeli.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              category.color,
              Colors.red,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16.0),
        child: Text(category.name),
      ),
    );
  }
}
