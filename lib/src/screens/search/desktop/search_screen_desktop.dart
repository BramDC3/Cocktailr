import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/blocs/search_bloc.dart';
import 'package:cocktailr/src/screens/search/desktop/widgets/search_screen_list_item_desktop.dart';
import 'package:cocktailr/src/screens/search/widgets/clear_field_icon.dart';
import 'package:cocktailr/src/widgets/desktop/menu_bar_desktop.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreenDesktop extends StatefulWidget {
  @override
  _SearchScreenDesktopState createState() => _SearchScreenDesktopState();
}

class _SearchScreenDesktopState extends State<SearchScreenDesktop> {
  SearchBloc _searchBloc;
  TextEditingController _textEditingController;

  List<String> _filterIngredients(List<String> ingredients, String keyword) {
    List<String> filteredIngredients = [...ingredients];

    if (keyword != null && keyword.isNotEmpty) {
      filteredIngredients = filteredIngredients.where((i) => i.toLowerCase().contains(keyword.toLowerCase())).toList();
    }

    return filteredIngredients;
  }

  void _clearTextField() {
    _textEditingController.text = "";
    _searchBloc.changeKeyword("");
  }

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _searchBloc?.dispose();
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MenuBarDesktop(),
          Expanded(
            child: _buildSearchScreen(),
          )
        ],
      ),
    );
  }

  Widget _buildSearchScreen() => StreamBuilder(
        stream: _searchBloc.keyword,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Scaffold(
            appBar: _buildSearchBar(snapshot.data),
            body: _buildBody(snapshot.data),
          );
        },
      );

  Widget _buildSearchBar(String keyword) => AppBar(
        automaticallyImplyLeading: false,
        elevation: 3,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _emptySpace(),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: _textEditingController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                        cursorColor: Colors.black87,
                        decoration: InputDecoration.collapsed(
                          hintText: "Search by ingredient...",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                        ),
                        onChanged: _searchBloc.changeKeyword,
                      ),
                    ),
                    ClearFieldIcon(
                      keyword: keyword,
                      color: Colors.black87,
                      onPressed: _clearTextField,
                    ),
                  ],
                ),
              ),
            ),
            _emptySpace(),
          ],
        ),
      );

  Widget _buildBody(String keyword) => StreamBuilder(
        stream: Provider.of<IngredientBloc>(context).ingredientNames,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingSpinner();
          }

          List<String> ingredients = _filterIngredients(
            snapshot.data,
            keyword,
          );

          return GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              Provider.of<IngredientBloc>(context).fetchIngredient(ingredients[index]);

              return Padding(
                padding: EdgeInsets.all(4),
                child: SearchScreenListItemDesktop(
                  ingredientName: ingredients[index],
                ),
              );
            },
          );
        },
      );

  Widget _emptySpace() => Expanded(
        flex: 1,
        child: Container(),
      );
}
