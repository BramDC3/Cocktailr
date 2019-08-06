import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cocktailr/src/models/cocktail.dart';

const String _baseUrl = 'https://www.thecocktaildb.com/api/json/v1/36578';

class CocktailApi {
  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    try {
      final res = await http.get('$_baseUrl/lookup.php?i=$cocktailId');
      final cocktail = json.decode(res.body)['drinks'][0];

      return Cocktail.fromJson(cocktail);
    } catch (e) {
      print('Error while fetching cocktail by id: $e');
      return null;
    }
  }

  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    try {
      final res = await http.get('$_baseUrl/filter.php?i=$ingredient');
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

  Future<List<String>> fetchIngredients() async {
    try {
      final res = await http.get('$_baseUrl/list.php?i=list');
      final list = json.decode(res.body)['drinks'];

      List<String> ingredients = [];
      for (int i = 0; i < list.length; i++) {
        ingredients.add(list[i]['strIngredient1']);
      }

      return ingredients;
    } catch (e) {
      print('Error while fetching ingredients: $e');
      return [];
    }
  }
}
