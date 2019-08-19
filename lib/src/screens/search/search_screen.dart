import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/blocs/search_bloc.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc _searchBloc;
  TextEditingController _controller;

  Future<void> _onIngredientPressed(
    String ingredient,
    BuildContext context,
  ) async {
    CocktailBloc cocktailBloc = Provider.of<CocktailBloc>(context);
    cocktailBloc.fetchCocktailIdsByIngredient(ingredient);

    MainNavigationBloc mainNavigationBloc =
        Provider.of<MainNavigationBloc>(context);
    mainNavigationBloc.changeCurrentIndex(1);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _searchBloc?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    IngredientBloc ingredientBloc = Provider.of<IngredientBloc>(context);

    return StreamBuilder(
      stream: _searchBloc.keyword,
      builder: (context, AsyncSnapshot<String> keywordSnapshot) {
        return Scaffold(
          appBar: _buildSearchAppBar(keywordSnapshot.data),
          body: StreamBuilder(
            stream: ingredientBloc.ingredients,
            builder: (context, AsyncSnapshot<List<String>> ingredientSnapshot) {
              if (!ingredientSnapshot.hasData) {
                return loadingSpinner();
              }

              List<String> ingredients = [...ingredientSnapshot.data];
              String keyword = keywordSnapshot.data;

              if (keyword != null && keyword != "") {
                ingredients = ingredients
                    .where(
                        (i) => i.toLowerCase().contains(keyword.toLowerCase()))
                    .toList();
              }

              if (ingredients.length > 10) {
                ingredients = ingredients.sublist(0, 10);
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _onIngredientPressed(
                      ingredients[index],
                      context,
                    ),
                    child: ListTile(
                      leading: Icon(Icons.local_bar),
                      title: Text(ingredients[index]),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildSearchAppBar(String keyword) => AppBar(
        title: TextField(
          autofocus: true,
          controller: _controller,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: "Search by ingredient...",
            hintStyle: TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
          ),
          onChanged: _searchBloc.changeKeyword,
        ),
        actions: keyword == null || keyword == ""
            ? <Widget>[]
            : <Widget>[
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _controller.text = "";
                    _searchBloc.changeKeyword("");
                  },
                ),
              ],
      );
}
