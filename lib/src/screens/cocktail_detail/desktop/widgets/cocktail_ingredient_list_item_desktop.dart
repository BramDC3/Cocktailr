import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/models/enums/image_size.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CocktailIngredientListItemDesktop extends StatelessWidget {
  final String ingredientName;
  final String measurement;
  final bool isLastIngredient;

  CocktailIngredientListItemDesktop({
    @required this.ingredientName,
    @required this.measurement,
    @required this.isLastIngredient,
  });

  @override
  Widget build(BuildContext context) {
    final ingredientBloc = Provider.of<IngredientBloc>(context);

    return StreamBuilder(
      stream: ingredientBloc.ingredients,
      builder: (context, AsyncSnapshot<Map<String, Future<Ingredient>>> snapshot) {
        if (!snapshot.hasData) {
          return ListTile();
        }

        return _cocktailIngredientListItem(
          snapshot.data[ingredientName],
        );
      },
    );
  }

  Widget _cocktailIngredientListItem(Future<Ingredient> ingredientFuture) => FutureBuilder(
        future: ingredientFuture,
        builder: (context, AsyncSnapshot<Ingredient> snapshot) {
          if (!snapshot.hasData) {
            return ListTile();
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: <Widget>[
                _ingredientImage(snapshot.data),
                SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _ingredientName(),
                    SizedBox(height: 4),
                    _ingredientMeasurement(),
                  ],
                ),
              ],
            ),
          );
        },
      );

  Widget _ingredientImage(Ingredient ingredient) => FadeInImage(
        image: NetworkImage("${ingredient.image(ImageSize.LARGE)}"),
        fit: BoxFit.contain,
        height: 80,
        width: 80,
        placeholder: AssetImage("assets/images/white_placeholder.png"),
      );

  Widget _ingredientName() => Text(
        ingredientName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _ingredientMeasurement() => Text(
        measurement,
        style: TextStyle(color: Colors.black54),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
}
