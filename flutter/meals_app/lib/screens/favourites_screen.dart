import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/screens/meal_details_screen.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    List<MealModel> favourites = ref.watch(favouriteMealsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: ListView.builder(
        itemCount: favourites.length,
        itemBuilder: (context, index) => ListTile(
          leading: Image.network(favourites[index].imageUrl),
          title: Text(favourites[index].name),
          subtitle: Text('${favourites[index].ingredients.first} ...'),
          trailing: IconButton(
            onPressed: () {
              ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavourite(favourites[index]);
            },
            icon: const Icon(Icons.delete),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MealDetailsScreen(
                  mealModel: favourites[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
