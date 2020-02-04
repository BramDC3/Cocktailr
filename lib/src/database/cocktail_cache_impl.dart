import 'dart:math';

import 'package:cocktailr/src/bases/database/cocktail_cache.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/services/crash_reporting_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class CocktailCacheImpl extends CocktailCache {
  final Box<Cocktail> _cocktailBox;
  final CrashReportingService _crashReportingService;

  CocktailCacheImpl(this._cocktailBox, this._crashReportingService,);

  @override
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      return _cocktailBox.get(cocktailId);
    } catch (e, stacktrace) {
      debugPrint('Error while fetching cocktail by id from cocktail cache: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
      return null;
    }
  }

  @override
  Future<Cocktail> fetchRandomCocktail() async {
    try {
      if (_cocktailBox.isEmpty) {
        return null;
      }

      final index = Random.secure().nextInt(_cocktailBox.length);
      return _cocktailBox.getAt(index);
    } catch (e, stacktrace) {
      debugPrint('Error while fetching random cocktail from cocktail cache: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
      return null;
    }
  }

  @override
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      final cocktails = _cocktailBox.values.where((cocktail) => cocktail.ingredients.contains(ingredient)).toList();

      if (cocktails?.isEmpty ?? true) {
        return [];
      }

      cocktails.sort((a, b) => a.name.compareTo(b.name));
      return cocktails.map((cocktail) => cocktail.id).toList();
    } catch (e, stacktrace) {
      debugPrint('Error while fetching cocktailids by ingredient from cocktail cache: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
      return [];
    }
  }

  @override
  Future<void> insertCocktail(Cocktail cocktail) async {
    try {
      await _cocktailBox.put(cocktail.id, cocktail);
    } catch (e, stacktrace) {
      debugPrint('Error while inserting cocktail in cocktail cache: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
    }
  }
}
