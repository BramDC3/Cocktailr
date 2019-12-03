import 'package:cocktailr/src/bases/database/cache_base.dart';
import 'package:cocktailr/src/bases/database/ingredient_cache.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:hive/hive.dart';

class IngredientCacheImpl extends IngredientCache implements CacheBase {
  Box<Ingredient> db;

  IngredientCacheImpl() {
    init();
  }

  @override
  Future<void> init() async {
    db = await Hive.openBox<Ingredient>("Ingredients");
  }

  @override
  Future<void> openBoxIfNecessary() async {
    if (db == null || !db.isOpen) {
      await init();
    }
  }

  @override
  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    try {
      await openBoxIfNecessary();
      
      return db.get(ingredientName);
    } catch (e) {
      print('Error while fetching ingredient by name from ingredient cache: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchIngredientNames() async {
    try {
      await openBoxIfNecessary();

      final ingredients = db.values.toList();

      if (ingredients?.isEmpty ?? true) {
        return [];
      }

      ingredients.sort((a, b) => a.name.compareTo(b.name));
      return ingredients.map((ingredient) => ingredient.name).toList();
    } catch (e) {
      print('Error while fetching ingredient names from ingredient cache: $e');
      return [];
    }
  }

  @override
  Future<void> insertIngredient(Ingredient ingredient) async {
    try {
      await openBoxIfNecessary();

      await db.put(ingredient.name, ingredient);
    } catch (e) {
      print('Error while inserting ingredient in ingredient cache: $e');
    }
  }
}
