import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<MealModel>>(
        (ref) => FavouriteMealsNotifier());

class FavouriteMealsNotifier extends StateNotifier<List<MealModel>> {
  FavouriteMealsNotifier() : super([]);

  void toggleMealFavourite(MealModel mealModel) {
    if (state.contains(mealModel)) {
      state = state.where((element) => element.id != mealModel.id).toList();
    } else {
      state = [...state, mealModel];
    }
  }
}
