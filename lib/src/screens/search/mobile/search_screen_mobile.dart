import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/blocs/search_bloc.dart';
import 'package:cocktailr/src/screens/search/mobile/widgets/search_screen_list_item_mobile.dart';
import 'package:cocktailr/src/screens/search/widgets/clear_field_icon.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreenMobile extends StatefulWidget {
  @override
  _SearchScreenMobileState createState() => _SearchScreenMobileState();
}

class _SearchScreenMobileState extends State<SearchScreenMobile> {
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
    return StreamBuilder(
      stream: _searchBloc.keyword,
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
          decoration: InputDecoration.collapsed(
            hintText: "Search by ingredient...",
            hintStyle: TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
          ),
          onChanged: _searchBloc.changeKeyword,
        ),
        actions: <Widget>[
          ClearFieldIcon(
            keyword: keyword,
            color: Colors.white,
            onPressed: _clearTextField,
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
              Provider.of<IngredientBloc>(context).fetchIngredient(ingredients[index]);

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: SearchScreenListItemMobile(
                  ingredientName: ingredients[index],
                ),
              );
            },
          );
        },
      );
}
