import 'package:cocktailr/src/database/cocktail_db_sqflite.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/network/cocktail_api.dart';

class CocktailRepository {
  List<CocktailSource> sources = <CocktailSource>[
    cocktailDbSqflite,
    CocktailApi(),
  ];

  List<CocktailCache> caches = <CocktailCache>[
    cocktailDbSqflite,
  ];

  // TO DO
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    return sources[1].fetchCocktailIdsByIngredient(ingredient);
  }

  // TO DO
  Future<List<String>> fetchPopularCocktailIds() async {
    return ["11002", "11001", "11000", "13621", "17207"];
  }

  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    Cocktail cocktail;
    var source;

    for (source in sources) {
      cocktail = await source.fetchCocktailById(cocktailId);
      if (cocktail != null) break;
    }

    if (cocktail != null) {
      for (var cache in caches) {
        if (cache != source) {
          cache.insertCocktail(cocktail);
        }
      }
    }

    return cocktail;
  }

  // TO DO
  Future<Cocktail> fetchRandomCocktail() async {
    return sources[1].fetchRandomCocktail();
  }
}

abstract class CocktailSource {
  Future<Cocktail> fetchCocktailById(String cocktailId);
  Future<Cocktail> fetchRandomCocktail();
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient);
}

abstract class CocktailCache {
  Future<int> insertCocktail(Cocktail cocktail);
}
