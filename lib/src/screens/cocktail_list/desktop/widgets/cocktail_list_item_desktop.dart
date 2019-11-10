import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cocktail_list_item_desktop_loading_container.dart';

class CocktailListItemDesktop extends StatelessWidget {
  final String cocktailId;

  CocktailListItemDesktop({@required this.cocktailId});

  void _selectCocktail(Cocktail cocktail, BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    cocktailBloc.selectCocktail(cocktail);
  }

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    final height = 100.0;

    return StreamBuilder(
      stream: cocktailBloc.cocktails,
      builder: (context, AsyncSnapshot<Map<String, Future<Cocktail>>> snapshot) {
        if (!snapshot.hasData) {
          return CocktailListItemDesktopLoadingContainer();
        }

        return _cocktailListItem(snapshot.data[cocktailId], height);
      },
    );
  }

  Widget _cocktailListItem(Future<Cocktail> cocktailFuture, double height) => FutureBuilder(
        future: cocktailFuture,
        builder: (context, AsyncSnapshot<Cocktail> snapshot) {
          if (!snapshot.hasData) {
            return CocktailListItemDesktopLoadingContainer();
          }

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () => _selectCocktail(snapshot.data, context),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                child: Row(
                  children: <Widget>[
                    _cocktailImage(
                      snapshot.data,
                      height,
                    ),
                    Expanded(
                      child: _cocktailDetails(
                        snapshot.data,
                        height,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  Widget _cocktailImage(Cocktail cocktail, double height) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FadeInImage(
          image: NetworkImage("${cocktail.image}"),
          placeholder: AssetImage("assets/images/white_placeholder.png"),
          width: height,
          height: height,
          fit: BoxFit.cover,
        ),
      );

  Widget _cocktailDetails(Cocktail cocktail, double height) => Container(
        height: height,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              cocktail.name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              cocktail.ingredients.toString().replaceAll('[', '').replaceAll(']', ''),
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
