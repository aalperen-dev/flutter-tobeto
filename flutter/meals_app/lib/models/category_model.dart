import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final Color color;

  CategoryModel({
    required this.id,
    required this.name,
    this.color = Colors.orange,
  });
}
