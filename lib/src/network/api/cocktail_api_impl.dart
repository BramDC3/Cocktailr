import 'package:cocktailr/src/bases/network/api/cocktail_api.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CocktailApiImpl extends CocktailApi {
  final Dio dio;

  CocktailApiImpl({@required this.dio});

  @override
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      final res = await dio.get('/lookup.php?i=$cocktailId');
      
      return compute(parseCocktail, res.data);
    } catch (e) {
      print('Error while fetching cocktail by id: $e');
      return null;
    }
  }

  @override
  Future<Cocktail> fetchRandomCocktail() async {
    try {
      final res = await dio.get('/random.php');

      return compute(parseCocktail, res.data);
    } catch (e) {
      print('Error while fetching random cocktail: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      final res = await dio.get('/filter.php?i=$ingredient');

      return compute(parseCocktailIds, res.data);
    } catch (e) {
      print('Error while fetching cocktail ids by ingredient: $e');
      return [];
    }
  }
}

Cocktail parseCocktail(dynamic responseData) {
  return Cocktail.fromJson(responseData['drinks'][0]);
}

List<String> parseCocktailIds(dynamic responseData) {
  return (responseData['drinks'] as List<dynamic>).map((cocktail) => cocktail['idDrink'] as String).toList();
}
