import 'package:cocktailr/src/bases/network/api/cocktail_api.dart';
import 'package:cocktailr/src/network/clients/cocktail_client.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:flutter/foundation.dart';

class CocktailApiImpl extends CocktailApi {
  final CocktailClient cocktailClient;

  CocktailApiImpl({@required this.cocktailClient});

  @override
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      final res = await cocktailClient.dio.get('/lookup.php?i=$cocktailId');
      final cocktail = res.data['drinks'][0];

      return Cocktail.fromJson(cocktail);
    } catch (e) {
      print('Error while fetching cocktail by id: $e');
      return null;
    }
  }

  @override
  Future<Cocktail> fetchRandomCocktail() async {
    try {
      final res = await cocktailClient.dio.get('/random.php');
      final cocktail = res.data['drinks'][0];

      return Cocktail.fromJson(cocktail);
    } catch (e) {
      print('Error while fetching random cocktail: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      final res = await cocktailClient.dio.get('/filter.php?i=$ingredient');
      final list = res.data['drinks'];

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
