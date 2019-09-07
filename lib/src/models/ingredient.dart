import 'package:flutter/foundation.dart';

class Ingredient {
  final String name;
  final String imageUrl;

  Ingredient({
    @required this.name,
    @required this.imageUrl,
  });
}

List<Ingredient> get popularIngredients => [
      Ingredient(
        name: "Tequila",
        imageUrl: "assets/images/ingredients/tequila.jpeg",
      ),
      Ingredient(
        name: "Vodka",
        imageUrl: "assets/images/ingredients/vodka.jpg",
      ),
      Ingredient(
        name: "Rum",
        imageUrl: "assets/images/ingredients/rum.jpg",
      ),
      Ingredient(
        name: "Gin",
        imageUrl: "assets/images/ingredients/gin.jpg",
      ),
      Ingredient(
        name: "Whiskey",
        imageUrl: "assets/images/ingredients/whiskey.jpg",
      ),
    ];
