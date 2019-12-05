import 'package:cocktailr/src/enums/image_size.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../app_config.dart';
import '../extensions/string_extensions.dart';
import '../extensions/image_size_extensions.dart';

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

  String image(ImageSize imageSize) {
    return "${AppConfig.imageBaseUrl}/$name-${imageSize.stringValue}.png";
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['idIngredient'],
      name: (json['strIngredient'] as String).allWordsCapitalized,
      description: json['strDescription'],
      type: json['strType'],
      isAlcoholic: json['strAlcohol'] == 'Yes',
      abv: json['strABV'],
    );
  }
}
