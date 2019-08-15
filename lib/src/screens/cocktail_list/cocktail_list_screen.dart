import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/constants/string_constants.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:cocktailr/src/widgets/no_items_available_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/cocktail_list_item.dart';

class CocktailListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);

    return StreamBuilder(
      stream: cocktailBloc.cocktailIds,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) {
          return loadingSpinner();
        }

        if (snapshot.data.isEmpty) {
          return noItemsAvailableText(ERROR_NO_COCKTAILS);
        }

        return _buildCocktailList(snapshot.data, cocktailBloc);
      },
    );
  }

  Widget _buildCocktailList(List<String> cocktailIds, CocktailBloc bloc) =>
      ListView.builder(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
        itemCount: cocktailIds.length,
        itemBuilder: (BuildContext context, int index) {
          bloc.fetchCocktail(cocktailIds[index]);

          return CocktailListItem(
            cocktailId: cocktailIds[index],
          );
        },
      );
}
