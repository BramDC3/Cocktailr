import 'dart:convert';
import 'package:cocktailr/src/constants/url_constants.dart';
import 'package:cocktailr/src/repositories/ingredient_repository.dart';
import 'package:http/http.dart' as http;

class IngredientApi implements IngredientSource {
  Future<List<String>> fetchIngredients() async {
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
