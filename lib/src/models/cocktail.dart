import 'dart:convert';

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
      name: capitalizeName(json['strDrink']),
      category: refactorCategory(json['strCategory']),
      instructions: json['strInstructions'],
      image: json['strDrinkThumb'],
      isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
      ingredients: filterList(json, 'strIngredient'),
      measurements: filterList(json, 'strMeasure'),
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

  static List<String> filterList(Map<String, dynamic> json, String tag) {
    List<String> list = List.generate(15, (int i) => json['$tag${i + 1}']);
    list.removeWhere((i) => i == '' || i == ' ' || i == '\n' || i == null);
    return list;
  }

  static String capitalizeName(String name) {
    if (name == null || name.length <= 1) return name?.toUpperCase() ?? "";
    if (!name.contains(" ")) return "${name[0].toUpperCase()}${name.substring(1)}";
    return name
        .split(" ")
        .map((word) => "${word[0].toUpperCase()}${word.substring(1)}")
        .join(" ");
  }

  static String refactorCategory(String category) {
    switch (category) {
      case "Ordinary Drink":
        return "Mundane";
      case "Cocktail":
        return "Cocktail";
      case "Milk \/ Float \/ Shake":
        return "Milkshake";
      case "Other\/Unknown":
        return "Mundane";
      case "Cocoa":
        return "Cocoa";
      case "Shot":
        return "Shot";
      case "Coffee \/ Tea":
        return "Coffee / Tea";
      case "Homemade Liqueur":
        return "Liqueur";
      case "Punch \/ Party Drink":
        return "Party Drink";
      case "Beer":
        return "Beer";
      case "Soft Drink \/ Soda":
        return "Soda";
      default:
        return "Mundane";
    }
  }
}
