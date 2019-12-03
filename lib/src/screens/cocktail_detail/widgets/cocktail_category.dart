import 'package:cocktailr/src/constants/color_constants.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:flutter/material.dart';

class CocktailCategory extends StatelessWidget {
  final double width;
  final Cocktail cocktail;

  CocktailCategory({@required this.width, @required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 4,
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: Stack(
            children: <Widget>[
              Text(
                cocktail.category.toUpperCase(),
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 5
                    ..color = ColorConstants.borderedTextBorderColor,
                ),
              ),
              Text(
                cocktail.category.toUpperCase(),
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.defaultBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
