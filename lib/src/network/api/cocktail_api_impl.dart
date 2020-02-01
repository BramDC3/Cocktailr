import 'package:cocktailr/src/bases/network/api/cocktail_api.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/services/crash_reporting_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CocktailApiImpl extends CocktailApi {
  final Dio _dio;
  final CrashReportingService _crashReportingService;

  CocktailApiImpl(
    this._dio,
    this._crashReportingService,
  );

  @override
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      final res = await _dio.get('/lookup.php?i=$cocktailId');

      return compute(parseCocktail, res.data);
    } catch (e, stacktrace) {
      debugPrint('Error while fetching cocktail by id: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
      return null;
    }
  }

  @override
  Future<Cocktail> fetchRandomCocktail() async {
    try {
      final res = await _dio.get('/random.php');

      return compute(parseCocktail, res.data);
    } catch (e, stacktrace) {
      debugPrint('Error while fetching random cocktail: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
      return null;
    }
  }

  @override
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      final res = await _dio.get('/filter.php?i=$ingredient');
      return compute(parseCocktailIds, res.data);
    } catch (e, stacktrace) {
      debugPrint('Error while fetching cocktail ids by ingredient: $e');
      await _crashReportingService.reportCrash(e, stacktrace);
      return [];
    }
  }
}

Cocktail parseCocktail(dynamic responseData) {
  try {
    return Cocktail.fromJson(responseData['drinks'][0]);
  } catch (e) {
    debugPrint('Error while parsing cocktail from response data: $e');
    return null;
  }
}

List<String> parseCocktailIds(dynamic responseData) {
  try {
    return (responseData['drinks'] as List<dynamic>).map((cocktail) => cocktail['idDrink'] as String).toList();
  } catch (e) {
    debugPrint('Error while parsing cocktail ids from response data: $e');
    return [];
  }
}
