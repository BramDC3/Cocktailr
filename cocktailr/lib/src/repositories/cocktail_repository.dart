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

  List<String> _ingredients;
  Future<List<String>> get ingredients async {
    if (_ingredients == null || _ingredients.isEmpty) await _fetchIngredients();
    return _ingredients;
  }

  Future<void> _fetchIngredients() async {
    List<String> ingredients;

    for (final source in sources) {
      ingredients = await source.fetchIngredients();
      if (ingredients != null && ingredients.isNotEmpty) break;
    }

    _ingredients = ingredients ?? [];
  }

  // TO DO
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    return sources[1].fetchCocktailIdsByIngredient(ingredient);
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
}

abstract class CocktailSource {
  Future<Cocktail> fetchCocktailById(String cocktailId);
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient);
  Future<List<String>> fetchIngredients();
}

abstract class CocktailCache {
  Future<int> insertCocktail(Cocktail cocktail);
}
