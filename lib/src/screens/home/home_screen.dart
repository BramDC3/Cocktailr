import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/fluro_router.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:cocktailr/src/screens/home/widgets/popular_ingredient_list_item.dart';
import 'package:cocktailr/src/screens/home/widgets/trending_cocktail_list_item.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _onIngredientPressed(
      Ingredient ingredient, BuildContext context) async {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    cocktailBloc.fetchCocktailIdsByIngredient(ingredient.name);

    final mainNavigationBloc = Provider.of<MainNavigationBloc>(context);
    mainNavigationBloc.changeCurrentIndex(1);
  }

  Future<void> _onMysteryCocktailButtonPressed(BuildContext context) async {
    final bloc = Provider.of<CocktailBloc>(context);
    final cocktail = await bloc.fetchRandomCocktail();
    bloc.fetchCocktail(cocktail.id);

    Navigator.of(context).pushNamed(
      FluroRouter.getCocktailDetailRoute(cocktail.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle("Trending Cocktails"),
          _buildTrendingCocktailsList(context),
          SizedBox(height: 16),
          _sectionTitle("Popular Ingredients"),
          _buildPopularIngredientsList(context),
          SizedBox(height: 16),
          _sectionTitle("Mystery Cocktail"),
          _buildMysteryCocktailButton(context),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: EdgeInsets.only(left: 19, bottom: 8, right: 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      );

  Widget _buildTrendingCocktailsList(BuildContext context) => StreamBuilder(
        stream: Provider.of<CocktailBloc>(context).popularCocktailIds,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingSpinner();
          }

          return Container(
            height: MediaQuery.of(context).size.height / 2.4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 16, right: 8),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Provider.of<CocktailBloc>(context)
                    .fetchCocktail(snapshot.data[index]);

                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: TrendingCocktailListItem(
                    cocktailId: snapshot.data[index],
                  ),
                );
              },
            ),
          );
        },
      );

  Widget _buildPopularIngredientsList(BuildContext context) => StreamBuilder(
        stream: Provider.of<IngredientBloc>(context).trendingIngredientNames,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingSpinner();
          }

          return Container(
            height: MediaQuery.of(context).size.height / 6,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 19, right: 8),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Provider.of<IngredientBloc>(context)
                    .fetchIngredient(snapshot.data[index]);

                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: PopularIngredientListItem(
                    ingredientName: snapshot.data[index],
                    onPressed: _onIngredientPressed,
                  ),
                );
              },
            ),
          );
        },
      );

  Widget _buildMysteryCocktailButton(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text(
                  "I'm feeling lucky",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => _onMysteryCocktailButtonPressed(context),
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      );
}
