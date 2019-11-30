import 'dart:convert';
import 'package:cocktailr/src/app_config.dart';
import 'package:cocktailr/src/bases/network/cocktail_api.dart';
import 'package:cocktailr/src/network/interceptors/cocktail_interceptors.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:dio/dio.dart';

class CocktailApiImpl extends CocktailApi {
  // TODO: Dependency injection
  Dio _dio = Dio(BaseOptions(
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      baseUrl: AppConfig.baseUrl,
    ))
      ..interceptors.add(CocktailInterceptors());

  @override
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      final res = await _dio.get('/lookup.php?i=$cocktailId');
      final cocktail = json.decode(res.data)['drinks'][0];

      return Cocktail.fromJson(cocktail);
    } catch (e) {
      print('Error while fetching cocktail by id: $e');
      return null;
    }
  }

  @override
  Future<Cocktail> fetchRandomCocktail() async {
    try {
      final res = await _dio.get('/random.php');
      final cocktail = json.decode(res.data)['drinks'][0];

      return Cocktail.fromJson(cocktail);
    } catch (e) {
      print('Error while fetching random cocktail: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      final res = await _dio.get('/filter.php?i=$ingredient');
      final list = json.decode(res.data)['drinks'];

      List<String> cocktailIds = [];
      for (int i = 0; i < list.length; i++) {
        cocktailIds.add(list[i]["idDrink"]);
      }

      return cocktailIds;
    } catch (e) {
      print('Error while fetching cocktail ids by ingredient: $e');
      return [];
    }
  }
}
