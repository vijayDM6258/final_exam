import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper dbHelper = DbHelper._();
  static Database? db;

  Future<Database> get database async {
    if (db != null) return db!;
    db = await _initDB();
    return db!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'recipe.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recipe (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            recipe TEXT,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertRecipe(String name, String recipe, int quantity) async {
    final db = await database;
    String query =
        "INSERT INTO recipe (name, recipe,quantity ) VALUES (?, ?,?)";
    int res = await db.rawInsert(query, [name, recipe, quantity]);
    return res;
  }

  Future<int> updateRecipe(
      int id, String name, String recipe, int quantity) async {
    final db = await database;
    String query =
        "UPDATE recipe SET name = ?, recipe = ?,quantity ?  WHERE id = ?";
    int res = await db.rawUpdate(query, [name, recipe, id, quantity]);
    return res;
  }

  Future<int> deleteSingleRecipe(int id) async {
    final db = await database;
    String query = "DELETE FROM recipe WHERE id = ?";
    int res = await db.rawDelete(query, [id]);
    return res;
  }

  Future<int> deleteAllRecipes() async {
    final db = await database;
    return await db.delete('recipe');
  }

  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    final db = await database;
    return await db.query('recipe');
  }
}
