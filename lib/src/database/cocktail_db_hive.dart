import 'dart:io';
import 'dart:math';

import 'package:cocktailr/src/bases/cocktail_cache.dart';
import 'package:cocktailr/src/bases/cocktail_source.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/utils/platform_utils.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class CocktailDbHive implements CocktailSource, CocktailCache {
  Box db;

  CocktailDbHive() {
    init();
  }

  Future<void> init() async {
    if (PlatformUtils.isMobileDevice()) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      Hive.init(documentsDirectory.path);
    }

    db = await Hive.openBox("Cocktails");
  }

  @override
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    if (db == null) await init();

    try {
      List<Cocktail> cocktails = List<Cocktail>.from(
          db.values.where((cocktail) => cocktail.id == cocktailId));

      if ((cocktails?.length ?? 0) != 0) {
        return cocktails.first;
      }

      return null;
    } catch (e) {
      print('Error while fetching cocktail by id from hive db: $e');
      return null;
    }
  }

  @override
  Future<Cocktail> fetchRandomCocktail() async {
    if (db == null) await init();

    try {
      List<Cocktail> cocktails = List<Cocktail>.from(db.values);

      if ((cocktails?.length ?? 0) != 0) {
        final index = Random().nextInt(cocktails.length);
        return cocktails[index];
      }

      return null;
    } catch (e) {
      print('Error while fetching random cocktail from hive db: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    if (db == null) await init();

    try {
      List<Cocktail> cocktails = List<Cocktail>.from(db.values)
          .where((cocktail) => cocktail.ingredients.contains(ingredient))
          .toList();

      if (cocktails?.isNotEmpty ?? false) {
        cocktails.sort((a, b) => a.name.compareTo(b.name));
        
        return cocktails.map((cocktail) => cocktail.id).toList();
      }

      return [];
    } catch (e) {
      print('Error while fetching cocktailids by ingredient from hive db: $e');
      return [];
    }
  }

  @override
  Future<int> insertCocktail(Cocktail cocktail) async {
    try {
      db.put(cocktail.id, cocktail);
      return 0;
    } catch (e) {
      print('Error while inserting cocktail in hive db: $e');
      return 1;
    }
  }
}

final cocktailDbHive = CocktailDbHive();
