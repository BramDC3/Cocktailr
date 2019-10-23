import 'dart:convert';

import 'package:cocktailr/src/constants/url_constants.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:http/http.dart' as http;

class IngredientApi {
  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    try {
      final res = await http.get('$cocktailDbBaseUrl/search.php?i=$ingredientName');
      final ingredient = json.decode(res.body)['ingredients'][0];

      return Ingredient.fromJson(ingredient);
    } catch(e) {
      print('Error while fetching ingredient by name: $e');
      return null;
    }
  }

  Future<List<String>> fetchIngredientsNames() async {
    try {
      final res = await http.get('$cocktailDbBaseUrl/list.php?i=list');
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
