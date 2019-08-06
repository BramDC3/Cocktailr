import 'package:cocktailr/src/constants/string_constants.dart';
import 'package:cocktailr/src/screens/cocktail_detail/cocktail_detail_screen.dart';
import 'package:cocktailr/src/screens/cocktail_list/cocktail_list_screen.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      onGenerateRoute: routes,
      home: CocktailListScreen(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => CocktailListScreen(),
        );
      case '/cocktail':
        String cocktailId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => CocktailDetailScreen(
            cocktailId: cocktailId,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => CocktailListScreen(),
        );
    }
  }
}
