import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/screens/cocktail_list/mobile/widgets/cocktail_list_item_mobile.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:cocktailr/src/widgets/no_items_available.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CocktailListScreenMobile extends StatelessWidget {
  const CocktailListScreenMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);

    return StreamBuilder(
      stream: cocktailBloc.cocktailIds,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingSpinner();
        }

        if (snapshot.data.isEmpty) {
          return NoItemsAvailable("Er zijn momenteel geen cocktails beschikbaar");
        }

        return _buildCocktailList(snapshot.data, cocktailBloc);
      },
    );
  }

  Widget _buildCocktailList(List<String> cocktailIds, CocktailBloc bloc) =>
      ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
        itemCount: cocktailIds.length,
        itemBuilder: (BuildContext context, int index) {
          bloc.fetchCocktail(cocktailIds[index]);

          return CocktailListItemMobile(
            cocktailId: cocktailIds[index],
          );
        },
      );
}