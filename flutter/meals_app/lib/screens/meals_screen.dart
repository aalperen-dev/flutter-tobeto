import 'package:flutter/material.dart';
import 'package:meals_app/data/meal_data.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/favourites_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_card.dart';

class MealsScreen extends StatelessWidget {
  final CategoryModel categoryModel;
  const MealsScreen({
    super.key,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    List<MealModel> mealList = meals
        .where(
          (element) => element.categoryId == categoryModel.id,
        )
        .toList();

    Widget widget = ListView.builder(
      itemCount: mealList.length,
      itemBuilder: (context, index) => MealCard(
        mealModel: mealList[index],
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MealDeatailsScreen(
                mealModel: mealList[index],
              ),
            ),
          );
        },
      ),
    );

    if (mealList.isEmpty) {
      widget = const Center(
        child: Text("Bu kategoride hiç bir yemek bulunamadı."),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${categoryModel.name} Yemekleri'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavouritesScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite_outline_outlined,
            ),
          ),
        ],
      ),
      body: widget,
    );
  }
}
