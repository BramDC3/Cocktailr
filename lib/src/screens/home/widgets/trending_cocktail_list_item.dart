import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/fluro_router.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/screens/home/widgets/trending_cocktail_loading_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingCocktailListItem extends StatelessWidget {
  final String cocktailId;

  TrendingCocktailListItem({@required this.cocktailId});

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    final width = MediaQuery.of(context).size.width;
    final imageHeight = MediaQuery.of(context).size.height / 3.5;

    return StreamBuilder(
      stream: cocktailBloc.cocktails,
      builder: (context, AsyncSnapshot<Map<String, Future<Cocktail>>> snapshot) {
        if (!snapshot.hasData) {
          return TrendingCocktailLoadingContainer();
        }

        return _buildCocktailListItem(
          snapshot.data[cocktailId],
          width,
          imageHeight,
          context,
        );
      },
    );
  }

  Widget _buildCocktailListItem(
    Future<Cocktail> cocktailFuture,
    double width,
    double height,
    BuildContext context,
  ) =>
      FutureBuilder(
        future: cocktailFuture,
        builder: (context, AsyncSnapshot<Cocktail> snapshot) {
          if (!snapshot.hasData) {
            return TrendingCocktailLoadingContainer();
          }

          return _cocktailListItem(
            snapshot.data,
            width,
            height,
            context,
          );
        },
      );

  Widget _cocktailListItem(
    Cocktail cocktail,
    double width,
    double height,
    BuildContext context,
  ) =>
      Container(
        width: MediaQuery.of(context).size.width / 1.2,
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.of(context).pushNamed(
              FluroRouter.getCocktailDetailRoute(cocktailId),
            ),
            child: Column(
              children: <Widget>[
                _cocktailImage(cocktail, height, width),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: _cocktailName(cocktail, width),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: _cocktailIngredients(cocktail, width),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _cocktailImage(Cocktail cocktail, double height, double width) =>
      Container(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: FadeInImage(
            image: NetworkImage("${cocktail.image}"),
            fit: BoxFit.cover,
            placeholder: AssetImage(
              "assets/images/white_placeholder.png",
            ),
          ),
        ),
      );

  Widget _cocktailName(Cocktail cocktail, double width) => Container(
        width: width,
        child: Text(
          cocktail.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.left,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _cocktailIngredients(Cocktail cocktail, double width) => Container(
        width: width,
        child: Text(
          cocktail.ingredients
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
}
