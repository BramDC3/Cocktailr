import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/fluro_router.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/screens/cocktail_list/widgets/cocktail_list_item_loading_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CocktailListItem extends StatelessWidget {
  final String cocktailId;

  CocktailListItem({@required this.cocktailId});

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    final height = MediaQuery.of(context).size.width / 4.2;

    return StreamBuilder(
      stream: cocktailBloc.cocktails,
      builder: (context, AsyncSnapshot<Map<String, Future<Cocktail>>> snapshot) {
        if (!snapshot.hasData) {
          return CocktailListItemLoadingContainer();
        }

        return _cocktailListItem(snapshot.data[cocktailId], height);
      },
    );
  }

  Widget _cocktailListItem(Future<Cocktail> cocktailFuture, double height) =>
      FutureBuilder(
        future: cocktailFuture,
        builder: (context, AsyncSnapshot<Cocktail> snapshot) {
          if (!snapshot.hasData) {
            return CocktailListItemLoadingContainer();
          }

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                FluroRouter.getCocktailDetailRoute(snapshot.data.id),
              ),
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
          image: CachedNetworkImageProvider("${cocktail.image}"),
          placeholder:
              AssetImage("assets/images/white_placeholder.png"),
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
              cocktail.ingredients
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', ''),
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
