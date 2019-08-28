import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/constants/string_constants.dart';
import 'package:cocktailr/src/screens/cocktail_detail/cocktail_detail_screen.dart';
import 'package:cocktailr/src/screens/main_screen.dart';
import 'package:cocktailr/src/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'blocs/cocktail_bloc.dart';
import 'blocs/ingredient_bloc.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        Provider(builder: (_) => CocktailBloc()),
        Provider(builder: (_) => IngredientBloc()),
        Provider(builder: (_) => MainNavigationBloc()),
      ],
      child: MaterialApp(
        title: APP_NAME,
        home: MainScreen(),
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MainScreen(),
        );
      case '/cocktail':
        String cocktailId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CocktailDetailScreen(
            cocktailId: cocktailId,
          ),
        );
      case '/search':
        return MaterialPageRoute(
          builder: (context) => SearchScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => MainScreen(),
        );
    }
  }
}
