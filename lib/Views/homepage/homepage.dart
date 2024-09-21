import 'package:final_exam/Views/Favoritepage/favoritepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/recipecontroller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RecipeController controller = Get.put(RecipeController());

  void _showRecipeDialog(BuildContext context,
      {int? id, String? name, String? recipeText, int? quantity}) {
    TextEditingController nameController =
        TextEditingController(text: name ?? '');
    TextEditingController recipeController =
        TextEditingController(text: recipeText ?? '');
    TextEditingController quantityController = TextEditingController(
        text: quantity != null ? quantity.toString() : '');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Add Recipe' : 'Update Recipe'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Recipe Name'),
              ),
              TextField(
                controller: recipeController,
                decoration: InputDecoration(labelText: 'Recipe Details'),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                String recipeText = recipeController.text;
                int quantity = int.parse(quantityController.text);

                if (id == null) {
                  controller.addRecipe(name, recipeText, quantity);
                } else {
                  controller.updateRecipe(id, name, recipeText, quantity);
                }

                Navigator.pop(context);
              },
              child: Text(id == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade300,
        elevation: 5,
        title: Text('Recipe App'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.fastfood_outlined,
            ),
            onPressed: () {
              Get.to(() => FavoritePage());
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              controller.deleteAllRecipes();
            },
          ),
        ],
      ),
      body: Obx(
        () {
          return controller.recipes.isEmpty
              ? Center(child: Text('Order any Recipe'))
              : ListView.builder(
                  itemCount: controller.recipes.length,
                  itemBuilder: (context, index) {
                    var recipe = controller.recipes[index];
                    return ListTile(
                      title: Text(recipe['name']),
                      subtitle: Text('Quantity: ${recipe['quantity']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showRecipeDialog(
                                context,
                                id: recipe['id'],
                                name: recipe['name'],
                                recipeText: recipe['recipe'],
                                quantity: recipe['quantity'],
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              controller.addToFavorites(recipe);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteRecipe(recipe['id']);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRecipeDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
