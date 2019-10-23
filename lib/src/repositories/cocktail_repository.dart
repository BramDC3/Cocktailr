import 'package:cocktailr/src/database/cocktail_cache.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/network/cocktail_api.dart';

class CocktailRepository {
  final CocktailApi cocktailApi = CocktailApi();
  final CocktailCache cocktailCache = CocktailCache();

  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    List<String> cocktailIds = await cocktailApi.fetchCocktailIdsByIngredient(ingredient);
    
    if (cocktailIds.isEmpty) {
      cocktailIds = await cocktailCache.fetchCocktailIdsByIngredient(ingredient);
    }

    return cocktailIds;
  }

  Future<List<String>> fetchPopularCocktailIds() async {
    return ["11002", "11001", "11000", "13621", "17207"];
  }

  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    Cocktail cocktail = await cocktailApi.fetchCocktailById(cocktailId);

    if (cocktail != null) {
      cocktailCache.insertCocktail(cocktail);
    } else {
      cocktail = await cocktailCache.fetchCocktailById(cocktailId);
    }

    return cocktail;
  }

  Future<Cocktail> fetchRandomCocktail() async {
    Cocktail cocktail = await cocktailApi.fetchRandomCocktail();

    if (cocktail == null) {
      cocktail = await cocktailCache.fetchRandomCocktail();
    }

    return cocktail;
  }
}
