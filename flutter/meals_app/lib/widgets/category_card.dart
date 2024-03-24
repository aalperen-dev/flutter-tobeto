import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  const CategoryCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Container();
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(name),
      ),
    );
  }
}
