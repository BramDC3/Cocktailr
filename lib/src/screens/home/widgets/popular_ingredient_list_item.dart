import 'package:cocktailr/src/models/ingredient.dart';
import 'package:flutter/material.dart';

class PopularIngredientListItem extends StatelessWidget {
  final Ingredient ingredient;
  final Function onPressed;

  PopularIngredientListItem({
    @required this.ingredient,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 6;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () => onPressed(
          ingredient,
          context,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: <Widget>[
              _ingredientImage(height),
              _ingredientOverlay(height),
              _ingredientName(height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ingredientImage(double height) => Image.asset(
        ingredient.imageUrl,
        height: height,
        width: height,
        fit: BoxFit.cover,
      );

  Widget _ingredientOverlay(double height) => Container(
        color: Colors.black.withOpacity(0.5),
        height: height,
        width: height,
      );

  Widget _ingredientName(double height) => Center(
        child: Container(
          height: height,
          width: height,
          padding: EdgeInsets.all(1),
          constraints: BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          child: Center(
            child: Text(
              ingredient.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
