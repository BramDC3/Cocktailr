import 'package:cocktailr/src/models/cocktail.dart';

abstract class CocktailSource {
  Future<Cocktail> fetchCocktailById(String cocktailId);
  Future<Cocktail> fetchRandomCocktail();
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient);
}
