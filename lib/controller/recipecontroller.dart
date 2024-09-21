import 'package:get/get.dart';
import '../helpers/sql_helper.dart';

class RecipeController extends GetxController {
  DbHelper dbHelper = DbHelper.dbHelper;

  var recipes = <Map<String, dynamic>>[].obs;
  var favoriteRecipes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  void fetchRecipes() async {
    var data = await dbHelper.fetchRecipes();
    recipes.value = data;
  }

  void addRecipe(String name, String recipe, int quantity) async {
    await dbHelper.insertRecipe(name, recipe, quantity);
    fetchRecipes();
  }

  void updateRecipe(int id, String name, String recipe, int quantity) async {
    await dbHelper.updateRecipe(id, name, recipe, quantity);
    fetchRecipes();
  }

  void deleteRecipe(int id) async {
    await dbHelper.deleteSingleRecipe(id);
    fetchRecipes();
  }

  void deleteAllRecipes() async {
    await dbHelper.deleteAllRecipes();
    fetchRecipes();
  }

  void addToFavorites(Map<String, dynamic> recipe) {
    favoriteRecipes.add(recipe);
  }
}
