import 'package:cocktailr/src/constants/string_constants.dart';
import 'package:cocktailr/src/screens/cocktail_detail/cocktail_detail_screen.dart';
import 'package:cocktailr/src/screens/cocktail_list/cocktail_list_screen.dart';
import 'package:cocktailr/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: APP_NAME,
      onGenerateRoute: routes,
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
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
