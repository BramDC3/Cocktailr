import 'package:cocktailr/src/models/ingredient.dart';

class PopularIngredients {
  static List<Ingredient> get popularIngredients => [
        Ingredient(
          name: "Tequila",
          imageUrl:
              "https://images.unsplash.com/photo-1459664018906-085c36f472af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80",
        ),
        Ingredient(
          name: "Vodka",
          imageUrl:
              "https://cdn.pixabay.com/photo/2017/03/05/01/22/barley-2117454_1280.jpg",
        ),
        Ingredient(
          name: "Rum",
          imageUrl:
              "https://cdn.pixabay.com/photo/2012/12/19/18/13/background-70997_1280.jpg",
        ),
        Ingredient(
          name: "Gin",
          imageUrl:
              "https://cdn.pixabay.com/photo/2015/03/12/07/51/juniper-669793_1280.jpg",
        ),
        Ingredient(
          name: "Whiskey",
          imageUrl:
              "https://cdn.pixabay.com/photo/2011/08/17/12/52/rye-8762_1280.jpg",
        ),
      ];
}
