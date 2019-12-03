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

      return compute(parseIngredient, res.data);
    } catch (e) {
      print('Error while fetching ingredient by name: $e');
      return null;
    }
  }

  @override
  Future<List<String>> fetchIngredientsNames() async {
    try {
      final res = await dio.get('/list.php?i=list');

      return compute(parseIngredientNames, res.data);
    } catch (e) {
      print('Error while fetching ingredients: $e');
      return [];
    }
  }
}

Ingredient parseIngredient(dynamic responseData) {
  return Ingredient.fromJson(responseData['ingredients'][0]);
}

List<String> parseIngredientNames(dynamic responseData) {
  return (responseData['drinks'] as List<dynamic>).map((ingredient) => ingredient['strIngredient1'] as String).toList();
}
