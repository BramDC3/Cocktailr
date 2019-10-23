import 'package:cocktailr/src/models/ingredient.dart';
import 'package:cocktailr/src/network/ingredient_api.dart';

class IngredientRepository {
  final IngredientApi ingredientApi = IngredientApi();

  Future<List<String>> fetchIngredientNames() async {
    return ingredientApi.fetchIngredientsNames();
  }

  Future<List<String>> fetchTrendingIngredientNames() async {
    return ["Tequila", "Vodka", "Rum", "Gin", "Whiskey"];
  }

  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    return ingredientApi.fetchIngredientByName(ingredientName);
  }
}
