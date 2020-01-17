import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'popular_ingredient_loading_container.dart';

class PopularIngredientListItem extends StatelessWidget {
  final String ingredientName;
  final Function onPressed;

  PopularIngredientListItem({
    @required this.ingredientName,
    @required this.onPressed,
  });

  String _getPopularIngredientImageUrl() => "assets/images/ingredients/${ingredientName.toLowerCase()}.jpg";

  @override
  Widget build(BuildContext context) {
    final ingredientBloc = Provider.of<IngredientBloc>(context);
    final height = MediaQuery.of(context).size.height / 6;

    return StreamBuilder(
      stream: ingredientBloc.ingredients,
      builder: (context, AsyncSnapshot<Map<String, Future<Ingredient>>> snapshot) {
        if (!snapshot.hasData) {
          return PopularIngredientLoadingContainer();
        }

        return _buildIngredientListItem(
          snapshot.data[ingredientName],
          height,
          context,
        );
      },
    );
  }

  Widget _buildIngredientListItem(
    Future<Ingredient> ingredientFuture,
    double height,
    BuildContext context,
  ) =>
      FutureBuilder(
        future: ingredientFuture,
        builder: (context, AsyncSnapshot<Ingredient> snapshot) {
          if (!snapshot.hasData) {
            return PopularIngredientLoadingContainer();
          }

          return _ingredientListItem(
            snapshot.data,
            height,
            context,
          );
        },
      );

  Widget _ingredientListItem(
    Ingredient ingredient,
    double height,
    BuildContext context,
  ) =>
      Padding(
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
                _ingredientImage(ingredient, height),
                _ingredientOverlay(height),
                _ingredientName(ingredient, height),
              ],
            ),
          ),
        ),
      );

  Widget _ingredientImage(Ingredient ingredient, double height) => Image.asset(
        _getPopularIngredientImageUrl(),
        height: height,
        width: height,
        fit: BoxFit.cover,
      );

  Widget _ingredientOverlay(double height) => Container(
        color: Colors.black.withOpacity(0.5),
        height: height,
        width: height,
      );

  Widget _ingredientName(Ingredient ingredient, double height) => Center(
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
