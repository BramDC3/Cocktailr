import 'dart:math';

import 'package:cocktailr/src/bases/database/cocktail_cache.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class CocktailCacheImpl extends CocktailCache {
  Box<Cocktail> cocktailBox;

  CocktailCacheImpl({@required this.cocktailBox});

  @override
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      return cocktailBox.get(cocktailId);
    } catch (e) {
      print('Error while fetching cocktail by id from cocktail cache: $e');
      return null;
    }
  }

  @override
  Future<Cocktail> fetchRandomCocktail() async {
    try {
      if (cocktailBox.isEmpty) {
        return null;
      }

      final index = Random.secure().nextInt(cocktailBox.length);
      return cocktailBox.getAt(index);
    } catch (e) {
      print('Error while fetching random cocktail from cocktail cache: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      final cocktails = cocktailBox.values.where((cocktail) => cocktail.ingredients.contains(ingredient)).toList();

      if (cocktails?.isEmpty ?? true) {
        return [];
      }

      cocktails.sort((a, b) => a.name.compareTo(b.name));
      return cocktails.map((cocktail) => cocktail.id).toList();
    } catch (e) {
      print('Error while fetching cocktailids by ingredient from cocktail cache: $e');
      return [];
    }
  }

  @override
  Future<void> insertCocktail(Cocktail cocktail) async {
    try {
      await cocktailBox.put(cocktail.id, cocktail);
    } catch (e) {
      print('Error while inserting cocktail in cocktail cache: $e');
    }
  }
}
