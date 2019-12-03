import 'package:cocktailr/src/models/ingredient.dart';

abstract class IngredientApi {
  Future<Ingredient> fetchIngredientByName(String ingredientName);
  Future<List<String>> fetchIngredientsNames();
}
