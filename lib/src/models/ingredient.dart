import 'package:cocktailr/src/constants/url_constants.dart';
import 'package:cocktailr/src/models/enum/image_size.dart';
import 'package:cocktailr/src/utils/string_utils.dart';
import 'package:flutter/foundation.dart';

class Ingredient {
  final String id;
  final String name;
  final String description;
  final String type;
  final bool isAlcoholic;
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

  factory Ingredient.fromDb(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      isAlcoholic: json['isAlcoholic'] == 1,
      abv: json['abv'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "type": type,
      "isAlcoholic": isAlcoholic ? 1 : 0,
      "abv": abv,
    };
  }
}

// List<Ingredient> get popularIngredients => [
//       Ingredient(
//         id: "t",
//         name: "Tequila",
//         image: "assets/images/ingredients/tequila.jpeg",
//       ),
//       Ingredient(
//         id: "v",
//         name: "Vodka",
//         image: "assets/images/ingredients/vodka.jpg",
//       ),
//       Ingredient(
//         id: "r",
//         name: "Rum",
//         image: "assets/images/ingredients/rum.jpg",
//       ),
//       Ingredient(
//         id: "g",
//         name: "Gin",
//         image: "assets/images/ingredients/gin.jpg",
//       ),
//       Ingredient(
//         id: "w",
//         name: "Whiskey",
//         image: "assets/images/ingredients/whiskey.jpg",
//       ),
//     ];
