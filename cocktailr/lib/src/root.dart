import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/constants/string_constants.dart';
import 'package:cocktailr/src/screens/cocktail_list/cocktail_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MultiProvider(
        providers: [
          Provider(builder: (context) => CocktailBloc()),
        ],
        child: CocktailListScreen(),
      ),
    );
  }
}
