import 'package:cocktailr/src/database/ingredient_cache.dart';
import 'package:cocktailr/src/extensions/string_extensions.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:cocktailr/src/network/ingredient_api.dart';

class IngredientRepository {
  final IngredientApi ingredientApi = IngredientApi();
  final IngredientCache ingredientCache = IngredientCache();

  Future<List<String>> fetchIngredientNames() async {
    List<String> ingredientNames = await ingredientApi.fetchIngredientsNames();

    // if (ingredientNames.isEmpty) {
    //   ingredientNames = await ingredientCache.fetchIngredientNames();
    // }

    ingredientNames = ingredientNames.where((i) => StringExtensions.containsNoUnicodeCharacters(i)).toList();

    return ingredientNames;
  }

  Future<List<String>> fetchTrendingIngredientNames() async {
    return ["Tequila", "Vodka", "Rum", "Gin", "Whiskey"];
  }

  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    Ingredient ingredient = await ingredientApi.fetchIngredientByName(ingredientName);

    if (ingredient == null) {
      ingredient = await ingredientApi.fetchIngredientByName(ingredientName);

      // if (ingredient != null) {
      //   ingredientCache.insertIngredient(ingredient);
      // }
    }

    return ingredient;
  }
}
