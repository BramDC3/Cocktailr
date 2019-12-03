import 'package:cocktailr/src/bases/database/ingredient_cache.dart';
import 'package:cocktailr/src/bases/network/api/ingredient_api.dart';
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
    List<String> ingredientNames = await ingredientApi.fetchIngredientsNames();

    if (ingredientNames.isEmpty) {
      ingredientNames = await ingredientCache.fetchIngredientNames();
    }

    return ingredientNames;
  }

  Future<List<String>> fetchTrendingIngredientNames() async {
    return ["Tequila", "Vodka", "Rum", "Gin", "Whiskey"];
  }

  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    Ingredient ingredient = await ingredientCache.fetchIngredientByName(ingredientName);

    if (ingredient == null) {
      ingredient = await ingredientApi.fetchIngredientByName(ingredientName);
      ingredientCache.insertIngredient(ingredient);
    }

    return ingredient;
  }
}
