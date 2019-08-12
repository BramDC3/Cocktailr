import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/constants/string_constants.dart';
import 'package:cocktailr/src/screens/home/widgets/popular_cocktail_list_item.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _sectionTitle("Trending Cocktails"),
            _buildTrendingCocktailsList(cocktailBloc),

            // Feeling brave
            // MysteryCocktailButton()

            // Common ingredients
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: EdgeInsets.only(left: 16, bottom: 8, right: 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      );

  Widget _buildTrendingCocktailsList(CocktailBloc bloc) => StreamBuilder(
        stream: bloc.popularCocktailIds,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return loadingSpinner();
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
                bloc.fetchCocktail(snapshot.data[index]);

                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: PopularCocktailListItem(
                    cocktailId: snapshot.data[index],
                  ),
                );
              },
            ),
          );
        },
      );
}
