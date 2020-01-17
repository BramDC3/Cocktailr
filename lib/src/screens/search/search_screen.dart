import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/blocs/search_bloc.dart';
import 'package:cocktailr/src/screens/search/widgets/search_screen_list_item.dart';
import 'package:cocktailr/src/services/app_localizations.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final SearchBloc searchBloc;

  SearchScreen({@required this.searchBloc});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController;

  List<String> _filterIngredients(List<String> ingredients, String keyword) {
    List<String> filteredIngredients = [...ingredients];

    if (keyword != null && keyword.isNotEmpty) {
      filteredIngredients = filteredIngredients
          .where((i) => i.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    return filteredIngredients;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    widget.searchBloc?.dispose();
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.searchBloc.keyword,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Scaffold(
          appBar: _buildAppBar(snapshot.data),
          body: _buildBody(snapshot.data),
        );
      },
    );
  }

  Widget _buildAppBar(String keyword) => AppBar(
        title: TextField(
          autofocus: true,
          controller: _textEditingController,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).searchPlaceHolderSearchText,
            hintStyle: TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
          ),
          onChanged: widget.searchBloc.changeKeyword,
        ),
        actions: keyword == null || keyword == ""
            ? <Widget>[]
            : <Widget>[
                IconButton(
                  icon: Icon(Icons.clear),
                  tooltip: AppLocalizations.of(context).searchButtonClearEntry,
                  onPressed: () {
                    _textEditingController.text = "";
                    widget.searchBloc.changeKeyword("");
                  },
                ),
              ],
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

          return ListView.builder(
            shrinkWrap: true,
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              Provider.of<IngredientBloc>(context)
                  .fetchIngredient(ingredients[index]);

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: SearchScreenListItem(
                  ingredientName: ingredients[index],
                ),
              );
            },
          );
        },
      );
}
