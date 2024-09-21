import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/recipecontroller.dart';

class FavoritePage extends StatelessWidget {
  final RecipeController recipeController = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
      ),
      body: Obx(() {
        return recipeController.favoriteRecipes.isEmpty
            ? Center(child: Text('No Favorite Recipes'))
            : ListView.builder(
          itemCount: recipeController.favoriteRecipes.length,
          itemBuilder: (context, index) {
            var recipe = recipeController.favoriteRecipes[index];
            return ListTile(
              title: Text(recipe['name']),
              subtitle: Text('Quantity: ${recipe['quantity']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  recipeController.favoriteRecipes(recipe['id']);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
