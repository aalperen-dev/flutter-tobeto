import 'package:meals_app/models/meal_model.dart';

const meals = [
  MealModel(
    id: "1",
    categoryId: "1",
    name: "Mercimek Çorbası",
    imageUrl:
        "https://cdn.yemek.com/mnresize/940/940/uploads/2014/06/mercimek-corbasi-yemekcom.jpg",
    ingredients: ["Mercimek", "Tuz"],
    desc:
        'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
    rating: 4.5,
  ),
  MealModel(
    id: "2",
    categoryId: "1",
    name: "Ezogelin Çorbası",
    imageUrl:
        "https://cdn.yemek.com/mnresize/940/940/uploads/2014/06/ezogelin-corbasi-yemekcom.jpg",
    ingredients: ["Salça", "Tuz"],
    desc:
        'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
    rating: 2.5,
  ),
];
