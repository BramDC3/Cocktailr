import 'dart:convert';

import 'package:cocktailr/src/utils/string_utils.dart';
import 'package:flutter/widgets.dart';

class Cocktail {
  final String id;
  final String name;
  final String category;
  final String instructions;
  final String image;
  final bool isAlcoholic;
  final List<dynamic> ingredients;
  final List<dynamic> measurements;

  Cocktail({
    @required this.id,
    @required this.name,
    @required this.category,
    @required this.instructions,
    @required this.image,
    @required this.isAlcoholic,
    @required this.ingredients,
    @required this.measurements,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['idDrink'],
      name: json['strDrink'],
      category: StringUtils.getCategory(json['strCategory']),
      instructions: json['strInstructions'],
      image: json['strDrinkThumb'],
      isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
      ingredients: _toList(json, 'strIngredient'),
      measurements: _toList(json, 'strMeasure'),
    );
  }

  factory Cocktail.fromDb(Map<String, dynamic> json) {
    return Cocktail(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      instructions: json['instructions'],
      image: json['image'],
      isAlcoholic: json['isAlcoholic'] == 1,
      ingredients: jsonDecode(json['ingredients']),
      measurements: jsonDecode(json['measurements']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "category": category,
      "instructions": instructions,
      "image": image,
      "isAlcoholic": isAlcoholic ? 1 : 0,
      "ingredients": jsonEncode(ingredients),
      "measurements": jsonEncode(measurements),
    };
  }

  static List<String> _toList(Map<String, dynamic> json, String tag) {
    List<String> list = List.generate(15, (int i) => json['$tag${i + 1}']);
    list.removeWhere((i) => i == '' || i == ' ' || i == '\n' || i == null);
    return list;
  }
}
