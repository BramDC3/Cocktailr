import 'package:cocktailr/src/models/cocktail.dart';

abstract class CocktailCache {
  Future<int> insertCocktail(Cocktail cocktail);
}
