import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/fluro_router.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/screens/home/widgets/trending_cocktail_loading_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingCocktailListItem extends StatelessWidget {
  TrendingCocktailListItem({@required this.cocktailId});
  final String cocktailId;

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);

    return StreamBuilder(
      stream: cocktailBloc.cocktails,
      builder:
          (context, AsyncSnapshot<Map<String, Future<Cocktail>>> snapshot) {
        if (!snapshot.hasData) {
          return TrendingCocktailLoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[cocktailId],
          builder: (context, AsyncSnapshot<Cocktail> cocktailSnapshot) {
            if (!cocktailSnapshot.hasData) {
              return TrendingCocktailLoadingContainer();
            }

            return Container(
              width: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.of(context).pushNamed(
                    FluroRouter.getCocktailDetailRoute(cocktailId),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: FadeInImage(
                            image: CachedNetworkImageProvider("${cocktailSnapshot.data.image}"),
                            placeholder: AssetImage("assets/images/ingredients/white_placeholder.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "${cocktailSnapshot.data.name}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            cocktailSnapshot.data.ingredients
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
