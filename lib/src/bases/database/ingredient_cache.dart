import 'package:cocktailr/src/models/ingredient.dart';

abstract class IngredientCache {
  Future<Ingredient> fetchIngredientByName(String ingredientName);
  Future<List<String>> fetchIngredientNames();
  Future<void> insertIngredient(Ingredient ingredient);
}
