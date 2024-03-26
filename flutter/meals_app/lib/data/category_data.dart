import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:meals_app/models/category_model.dart';

// guid paket

final categories = [
  CategoryModel(
    id: Guid.generate().toString(),
    name: 'Kategori 1',
    color: Colors.purple,
  ),
  CategoryModel(
    id: '1',
    name: 'Kategori 2',
    color: Colors.red,
  ),
  CategoryModel(
    id: Guid.generate().toString(),
    name: 'Kategori 3',
    color: Colors.blue,
  ),
  CategoryModel(
    id: Guid.generate().toString(),
    name: 'Kategori 4',
    color: Colors.yellow,
  ),
  CategoryModel(
    id: Guid.generate().toString(),
    name: 'Kategori 5',
    color: Colors.green,
  ),
];
