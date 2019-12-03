import 'package:cocktailr/src/constants/url_constants.dart';
import 'package:cocktailr/src/models/enum/image_size.dart';
import 'package:cocktailr/src/utils/string_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'ingredient.g.dart';

@HiveType()
class Ingredient extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String type;
  @HiveField(4)
  final bool isAlcoholic;
  @HiveField(5)
  final String abv;

  Ingredient({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.type,
    @required this.isAlcoholic,
    @required this.abv,
  });

  String image(ImageSize imageSize) =>
      "$ingredientImageBaseUrl/$name-${StringUtils.getSizeFromImageSize(imageSize)}.png";

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['idIngredient'],
      name: StringUtils.capitalizeAllWords(json['strIngredient']),
      description: json['strDescription'],
      type: json['strType'],
      isAlcoholic: json['strAlcohol'] == 'Yes',
      abv: json['strABV'],
    );
  }
}
