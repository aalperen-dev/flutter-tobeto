import 'package:flutter/material.dart';
import 'package:meals_app/data/meal_data.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: ListTile(
        leading: Image.network(meals[0].imageUrl),
        title: Text(meals[0].name),
        subtitle: Text('${meals[0].ingredients.first} ...'),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete),
        ),
        onTap: () {
          print('yemek tıklandı');
        },
      ),
    );
  }
}
