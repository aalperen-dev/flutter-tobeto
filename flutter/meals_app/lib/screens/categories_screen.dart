import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/screens/meals_screen.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _changeScreen(CategoryModel categoryModel, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          categoryModel: categoryModel,
        ),
      ),
    );
  }

  @override
  // * => Context objesi StatlessWidgetlarda yalnızca build fonksiyonu içerisinde erişime açıktır.
  // => Stateful Widgetlarda ise, build fonksiyonu dışından da erişilebilir.
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList = categories;
    return Scaffold(
      appBar: AppBar(
        // TODO: Favoriler sayfasına geçiş..
        title: const Text('Kategoriler'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.builder(
                itemCount: categoryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    categoryModel: categoryList[index],
                    onTap: () {
                      print('id: ${categoryList[index].id}');
                      // _changeScreen(categoryList[index], context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MealsScreen(
                            categoryModel: categoryList[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print(DateTime.now().microsecondsSinceEpoch);
      //   },
      // ),
    );
  }
}
