import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/enums/image_size.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreenListItem extends StatelessWidget {
  final String ingredientName;

  SearchScreenListItem({@required this.ingredientName});

  Future<void> _onIngredientPressed(String ingredient, BuildContext context) async {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    await cocktailBloc.fetchCocktailIdsByIngredient(ingredient);

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
        return ListTile();
      }

      return InkWell(
        onTap: () => _onIngredientPressed(snapshot.data.name, context),
        child: ListTile(
          leading: FadeInImage(
            image: CachedNetworkImageProvider("${snapshot.data.image(ImageSize.SMALL)}"),
            fit: BoxFit.cover,
            placeholder: AssetImage(
              "assets/images/white_placeholder.png",
            ),
          ),
          title: Text(snapshot.data.name),
        ),
      );
    },
  );
}
