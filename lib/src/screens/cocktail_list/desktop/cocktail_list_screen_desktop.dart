import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/screens/cocktail_detail/desktop/cocktail_detail_screen_desktop.dart';
import 'package:cocktailr/src/screens/cocktail_list/desktop/widgets/cocktail_list_item_desktop.dart';
import 'package:cocktailr/src/widgets/desktop/menu_bar_desktop.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:cocktailr/src/widgets/no_items_available.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CocktailListScreenDesktop extends StatelessWidget {
  const CocktailListScreenDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);

    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MenuBarDesktop(),
          Expanded(
            child: _buildCocktailListScreen(cocktailBloc),
          )
        ],
      ),
    );
  }

  Widget _buildCocktailListScreen(CocktailBloc cocktailBloc) => StreamBuilder(
      stream: cocktailBloc.cocktailIds,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingSpinner();
        }

        if (snapshot.data.isEmpty) {
          return NoItemsAvailable("Er zijn momenteel geen cocktails beschikbaar");
        }

        return _buildCocktailMasterDetailLayout(snapshot.data, cocktailBloc);
      },
    );

  Widget _buildCocktailMasterDetailLayout(List<String> cocktailIds, CocktailBloc bloc) => Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _buildCocktailList(cocktailIds, bloc),
            ),
            Expanded(
              flex: 2,
              child: CocktailDetailScreenDesktop(),
            ),
          ],
        ),
      );

  Widget _buildCocktailList(List<String> cocktailIds, CocktailBloc bloc) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
        itemCount: cocktailIds.length,
        itemBuilder: (BuildContext context, int index) {
          bloc.fetchCocktail(cocktailIds[index]);

          return CocktailListItemDesktop(
            cocktailId: cocktailIds[index],
          );
        },
      );
}
