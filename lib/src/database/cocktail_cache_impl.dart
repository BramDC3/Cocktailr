import 'dart:math';

import 'package:cocktailr/src/bases/database/cache_base.dart';
import 'package:cocktailr/src/bases/database/cocktail_cache.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:hive/hive.dart';

class CocktailCacheImpl extends CocktailCache implements CacheBase {
  Box<Cocktail> db;

  CocktailCacheImpl() {
    init();
  }

  @override
  Future<void> init() async {
    db = await Hive.openBox<Cocktail>("Cocktails");
  }

  @override
  Future<void> openBoxIfNecessary() async {
    if (db == null || !db.isOpen) {
      await init();
    }
  }

  @override
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      await openBoxIfNecessary();

      return db.get(cocktailId);
    } catch (e) {
      print('Error while fetching cocktail by id from cocktail cache: $e');
      return null;
    }
  }

  @override
  Future<Cocktail> fetchRandomCocktail() async {
    try {
      await openBoxIfNecessary();

      final cocktails = db.values.toList();

      if (cocktails?.isEmpty ?? true) {
        return null;
      }

      final index = Random.secure().nextInt(cocktails.length);
      return cocktails[index];
    } catch (e) {
      print('Error while fetching random cocktail from cocktail cache: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      await openBoxIfNecessary();

      final cocktails = db.values.where((cocktail) => cocktail.ingredients.contains(ingredient)).toList();

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
      await openBoxIfNecessary();

      await db.put(cocktail.id, cocktail);
    } catch (e) {
      print('Error while inserting cocktail in cocktail cache: $e');
    }
  }
}
