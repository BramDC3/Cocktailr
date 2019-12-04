import 'package:cocktailr/src/bases/database/ingredient_cache.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class IngredientCacheImpl extends IngredientCache {
  Box<Ingredient> ingredientBox;

  IngredientCacheImpl({@required this.ingredientBox});

  @override
  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    try {
      return ingredientBox.get(ingredientName);
    } catch (e) {
      print('Error while fetching ingredient by name from ingredient cache: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchIngredientNames() async {
    try {
      final ingredients = ingredientBox.values.toList();

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
      await ingredientBox.put(ingredient.name, ingredient);
    } catch (e) {
      print('Error while inserting ingredient in ingredient cache: $e');
    }
  }
}
