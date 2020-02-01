import 'package:cocktailr/src/bases/database/cocktail_cache.dart';
import 'package:cocktailr/src/bases/network/api/cocktail_api.dart';
import 'package:cocktailr/src/constants/app_config.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:flutter/material.dart';

class CocktailRepository {
  final CocktailApi cocktailApi;
  final CocktailCache cocktailCache;

  CocktailRepository({
    @required this.cocktailApi,
    @required this.cocktailCache,
  });

  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    var cocktailIds = await cocktailApi.fetchCocktailIdsByIngredient(ingredient);

    if (cocktailIds.isEmpty) {
      cocktailIds = await cocktailCache.fetchCocktailIdsByIngredient(ingredient);
    }

    return cocktailIds;
  }

  Future<List<String>> fetchPopularCocktailIds() async {
    return popularCocktailIds;
  }

  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    var cocktail = await cocktailApi.fetchCocktailById(cocktailId);

    if (cocktail != null) {
      await cocktailCache.insertCocktail(cocktail);
    } else {
      cocktail = await cocktailCache.fetchCocktailById(cocktailId);
    }

    return cocktail;
  }

  Future<Cocktail> fetchRandomCocktail() async {
    var cocktail = await cocktailCache.fetchRandomCocktail();

    if (cocktail == null) {
      cocktail = await cocktailApi.fetchRandomCocktail();
      await cocktailCache.insertCocktail(cocktail);
    }

    return cocktail;
  }
}
