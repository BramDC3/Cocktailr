import 'package:cocktailr/src/models/ingredient.dart';

class PopularIngredients {
  static List<Ingredient> get popularIngredients => [
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
}
