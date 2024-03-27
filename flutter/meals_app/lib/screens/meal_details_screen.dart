import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/favourites_screen.dart';

class MealDeatailsScreen extends StatelessWidget {
  final MealModel mealModel;
  const MealDeatailsScreen({
    super.key,
    required this.mealModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${mealModel.name} tarifi.'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FavouritesScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite_outline_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: mealModel.id,
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.network(mealModel.imageUrl),
                ),
              ),
            ),
            Text(mealModel.desc),
            // ListView.builder(
            //   itemCount: mealModel.ingredients.length,
            //   itemBuilder: (context, index) {},
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: RatingBarIndicator(
                rating: mealModel.rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
