import 'package:cocktailr/src/bases/cocktail_cache.dart';
import 'package:cocktailr/src/bases/cocktail_source.dart';
import 'package:cocktailr/src/database/cocktail_db_hive.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/network/cocktail_api.dart';

class CocktailRepository {
  List<CocktailSource> sources = <CocktailSource>[
    cocktailDbHive,
    CocktailApi(),
  ];

  List<CocktailCache> caches = <CocktailCache>[
    cocktailDbHive,
  ];

  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    List<String> cocktailIds = await sources[1].fetchCocktailIdsByIngredient(ingredient);
    
    if (cocktailIds?.isEmpty ?? true) {
      cocktailIds = await sources[0].fetchCocktailIdsByIngredient(ingredient);
    }

    return cocktailIds;
  }

  // TODO: I need to be a Patreon supporter to use this feature.
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

  Future<Cocktail> fetchRandomCocktail() async {
    Cocktail cocktail = await sources[1].fetchRandomCocktail();

    if (cocktail == null) {
      cocktail = await sources[0].fetchRandomCocktail();
    }

    return cocktail;
  }
}
