import 'package:cocktailr/src/bases/database/ingredient_cache.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:cocktailr/src/services/crash_reporting_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class IngredientCacheImpl extends IngredientCache {
  final Box<Ingredient> _ingredientBox;
  final CrashReportingService _crashReportingService;

  IngredientCacheImpl(
    this._ingredientBox,
    this._crashReportingService,
  );

  @override
  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    try {
      return _ingredientBox.get(ingredientName);
    } catch (e, stacktrace) {
      debugPrint('Error while fetching ingredient by name from ingredient cache: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
      return null;
    }
  }

  @override
  Future<List<String>> fetchIngredientNames() async {
    try {
      final ingredients = _ingredientBox.values.toList();

      if (ingredients?.isEmpty ?? true) {
        return [];
      }

      ingredients.sort((a, b) => a.name.compareTo(b.name));
      return ingredients.map((ingredient) => ingredient.name).toList();
    } catch (e, stacktrace) {
      debugPrint('Error while fetching ingredient names from ingredient cache: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
      return [];
    }
  }

  @override
  Future<void> insertIngredient(Ingredient ingredient) async {
    try {
      await _ingredientBox.put(ingredient.name, ingredient);
    } catch (e, stacktrace) {
      debugPrint('Error while inserting ingredient in ingredient cache: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
    }
  }
}
