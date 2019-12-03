import 'package:cocktailr/src/models/cocktail.dart';

abstract class CocktailCache {
  Future<Cocktail> fetchCocktailById(String cocktailId);
  Future<Cocktail> fetchRandomCocktail();
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient);
  Future<void> insertCocktail(Cocktail cocktail);
}
