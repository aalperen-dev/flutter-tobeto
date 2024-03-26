import 'package:flutter/material.dart';

import 'package:meals_app/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel categoryModel;
  final VoidCallback onTap;
  const CategoryCard({
    super.key,
    required this.categoryModel,
    required this.onTap,
  });

  // Dışarıdan alınan kategori modeli rengi ve ismi ile bu kartta kullanılmalı.
  // onTap aksiyonu, dışardan aldığı fonksiyonu haberdar etmeli.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, //Sadece dışarıyı haberdar et
      // onTap: () {
      //   onTap(); // Dışarıyı haberdar et
      //   // Varsa diğer işlemleri yürüt.
      // },
      child: Container(
        // height: 10,
        // width: 20,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              categoryModel.color.withOpacity(0.7),
              categoryModel.color.withOpacity(0.3)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Text(categoryModel.name),
      ),
    );
  }
}
