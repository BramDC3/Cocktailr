import 'package:cocktailr/src/utils/string_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'cocktail.g.dart';

@HiveType()
class Cocktail extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String instructions;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final bool isAlcoholic;
  @HiveField(6)
  final List<dynamic> ingredients;
  @HiveField(7)
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
      name: StringUtils.capitalizeAllWords(json['strDrink']),
      category: refactorCategory(json['strCategory']),
      instructions: json['strInstructions'],
      image: json['strDrinkThumb'],
      isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
      ingredients: filterList(json, 'strIngredient'),
      measurements: filterList(json, 'strMeasure'),
    );
  }

  static List<String> filterList(Map<String, dynamic> json, String tag) {
    if (json == null || tag == null || json.isEmpty || tag.isEmpty) return [];

    List<String> list = List.generate(json.length <= 15 ? json.length : 15, (int i) => json['$tag${i + 1}']);
    list.removeWhere((i) => i == '' || i == ' ' || i == '\n' || i == null);
    return list;
  }

  static String refactorCategory(String category) {
    switch (category?.toLowerCase()?.trim() ?? "") {
      case "ordinary drink":
      case "mundane":
        return "Mundane";
      case "cocktail":
        return "Cocktail";
      case "milk \/ float \/ shake":
      case "milkshake":
        return "Milkshake";
      case "other\/unknown":
        return "Mundane";
      case "cocoa":
        return "Cocoa";
      case "shot":
        return "Shot";
      case "coffee \/ tea":
      case "coffee / tea":
        return "Coffee / Tea";
      case "homemade liqueur":
      case "liqueur":
        return "Liqueur";
      case "punch \/ party drink":
      case "party drink":
        return "Party Drink";
      case "beer":
        return "Beer";
      case "soft drink \/ soda":
      case "soda":
        return "Soda";
      default:
        return "Mundane";
    }
  }
}
