import 'dart:convert';
import 'package:cocktailr/src/bases/cocktail_source.dart';
import 'package:cocktailr/src/constants/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:cocktailr/src/models/cocktail.dart';

class CocktailApi implements CocktailSource {
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      final res = await http.get('$cocktailDbBaseUrl/lookup.php?i=$cocktailId');
      final cocktail = json.decode(res.body)['drinks'][0];

      return Cocktail.fromJson(cocktail);
    } catch (e) {
      print('Error while fetching cocktail by id: $e');
      return null;
    }
  }

  Future<Cocktail> fetchRandomCocktail() async {
    try {
      final res = await http.get('$cocktailDbBaseUrl/random.php');
      final cocktail = json.decode(res.body)['drinks'][0];

      return Cocktail.fromJson(cocktail);
    } catch (e) {
      print ('Error while fetching random cocktail: $e');
      return null;
    }
  }

  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      final res = await http.get('$cocktailDbBaseUrl/filter.php?i=$ingredient');
      final list = json.decode(res.body)['drinks'];

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
