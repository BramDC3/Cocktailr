import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/models/enums/image_size.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreenListItemDesktop extends StatelessWidget {
  final String ingredientName;

  const SearchScreenListItemDesktop({@required this.ingredientName});

  Future<void> _onIngredientPressed(String ingredient, BuildContext context) async {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    cocktailBloc.fetchCocktailIdsByIngredient(ingredient);

    final mainNavigationBloc = Provider.of<MainNavigationBloc>(context);
    mainNavigationBloc.changeCurrentIndex(1);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ingredientBloc = Provider.of<IngredientBloc>(context);

    return StreamBuilder(
      stream: ingredientBloc.ingredients,
      builder: (context, AsyncSnapshot<Map<String, Future<Ingredient>>> snapshot) {
        if (!snapshot.hasData) {
          return ListTile();
        }

        return _searchScreenListItem(snapshot.data[ingredientName]);
      },
    );
  }

  Widget _searchScreenListItem(Future<Ingredient> ingredientFuture) => FutureBuilder(
        future: ingredientFuture,
        builder: (context, AsyncSnapshot<Ingredient> snapshot) {
          if (!snapshot.hasData) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => _onIngredientPressed(snapshot.data.name, context),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: FadeInImage(
                        image: NetworkImage("${snapshot.data.image(ImageSize.LARGE)}"),
                        fit: BoxFit.cover,
                        placeholder: AssetImage(
                          "assets/images/white_placeholder.png",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          snapshot.data.name,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
}
