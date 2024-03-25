import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class CategoryModel {
  final Guid id;
  final String name;
  final Color color;

  CategoryModel({
    required this.id,
    required this.name,
    this.color = Colors.orange,
  });
}
