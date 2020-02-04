import 'package:cocktailr/src/bases/database/ingredient_cache.dart';
import 'package:cocktailr/src/bases/network/api/ingredient_api.dart';
import 'package:cocktailr/src/constants/app_config.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientRepository {
  final IngredientApi ingredientApi;
  final IngredientCache ingredientCache;

  IngredientRepository({
    @required this.ingredientApi,
    @required this.ingredientCache,
  });

  Future<List<String>> fetchIngredientNames() async {
    var ingredientNames = await ingredientApi.fetchIngredientsNames();

    if (ingredientNames.isEmpty) {
      ingredientNames = await ingredientCache.fetchIngredientNames();
    }

    return ingredientNames;
  }

  Future<List<String>> fetchTrendingIngredientNames() async {
    return trendingIngredients;
  }

  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    var ingredient = await ingredientCache.fetchIngredientByName(ingredientName);

    if (ingredient == null) {
      ingredient = await ingredientApi.fetchIngredientByName(ingredientName);
      await ingredientCache.insertIngredient(ingredient);
    }

    return ingredient;
  }
}
