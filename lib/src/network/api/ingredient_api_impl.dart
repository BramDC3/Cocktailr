import 'package:cocktailr/src/bases/network/api/ingredient_api.dart';
import 'package:cocktailr/src/extensions/string_extensions.dart';
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
  try {
    return Ingredient.fromJson(responseData['ingredients'][0]);
  } catch (e) {
    print('Error while parsing ingredient: $e');
    return null;
  }
}

List<String> parseIngredientNames(dynamic responseData) {
  try {
    final ingredientNames = (responseData['drinks'] as List<dynamic>).map((ingredient) => ingredient['strIngredient1'] as String);
    return ingredientNames.where((ingredient) => !ingredient.containsNonAsciiCharacters).toList();
  } catch (e) {
    print('Error while parsing ingredient names: $e');
    return [];
  }
}
