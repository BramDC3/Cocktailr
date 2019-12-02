import 'package:cocktailr/src/bases/network/api/ingredient_api.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class IngredientApiImpl extends IngredientApi {
  final Dio dio;

  IngredientApiImpl({@required this.dio});

  @override
  Future<Ingredient> fetchIngredientByName(String ingredientName) async {
    try {
      final res = await dio.get('/search.php?i=$ingredientName');
      final ingredient = res.data['ingredients'][0];

      return Ingredient.fromJson(ingredient);
    } catch(e) {
      print('Error while fetching ingredient by name: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchIngredientsNames() async {
    try {
      final res = await dio.get('/list.php?i=list');
      final list = res.data['drinks'];

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
