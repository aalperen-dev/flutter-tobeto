import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meals_app/models/meal_model.dart';

class MealCard extends StatelessWidget {
  final MealModel mealModel;
  final VoidCallback onTap;
  const MealCard({
    super.key,
    required this.mealModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Hero(
        tag: mealModel.id,
        child: Card(
          child: Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(mealModel.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    mealModel.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
