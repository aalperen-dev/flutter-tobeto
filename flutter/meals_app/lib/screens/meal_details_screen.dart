import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
  final MealModel mealModel;
  const MealDetailsScreen({
    super.key,
    required this.mealModel,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MealDetailsScreenState();
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //
    final favourites = ref.watch(favouriteMealsProvider);
    //
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.mealModel.name} tarifi.'),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavourite(widget.mealModel);

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const FavouritesScreen(),
              //   ),
              // );
            },
            icon: Icon(
              favourites.contains(widget.mealModel)
                  ? Icons.favorite
                  : Icons.favorite_outline_outlined,
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
                tag: widget.mealModel.id,
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.network(widget.mealModel.imageUrl),
                ),
              ),
            ),
            Text(widget.mealModel.desc),
            // ListView.builder(
            //   itemCount: mealModel.ingredients.length,
            //   itemBuilder: (context, index) {},
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: RatingBarIndicator(
                rating: widget.mealModel.rating,
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
