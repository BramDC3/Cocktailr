import 'dart:io';

import 'package:cocktailr/src/models/ingredient.dart';
import 'package:cocktailr/src/utils/platform_utils.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class IngredientCache {
  Box db;

  IngredientCache() {
    init();
  }

  Future<void> init() async {
    if (PlatformUtils.isMobileDevice()) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      Hive.init(documentsDirectory.path);
    }

    db = await Hive.openBox("Ingredients");
  }

  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    if (db == null) await init();

    try {
      List<Ingredient> ingredients = List<Ingredient>.from(
          db.values.where((ingredient) => ingredient.name == ingredientName));

      if ((ingredients?.length ?? 0) != 0) {
        return ingredients.first;
      }

      return null;
    } catch (e) {
      print('Error while fetching ingredient by name from hive db: $e');
      return null;
    }
  }

  Future<List<String>> fetchIngredientNames() async {
    if (db == null) await init();

    try {
      List<Ingredient> ingredients = List<Ingredient>.from(db.values);

      if (ingredients?.isNotEmpty ?? false) {
        ingredients.sort((a, b) => a.name.compareTo(b.name));
        
        return ingredients.map((ingredient) => ingredient.name).toList();
      }

      return [];
    } catch (e) {
      print('Error while fetching ingredient names from hive db: $e');
      return [];
    }
  }

  Future<int> insertIngredient(Ingredient ingredient) async {
    try {
      db.put(ingredient.name, ingredient);
      return 0;
    } catch (e) {
      print('Error while inserting ingredient in hive db: $e');
      return 1;
    }
  }
}
