import 'package:cocktailr/src/constants/string_constants.dart';
import 'package:cocktailr/src/screens/cocktail_detail/cocktail_detail_screen.dart';
import 'package:cocktailr/src/screens/main_screen.dart';
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
        Provider(builder: (context) => CocktailBloc()),
        Provider(builder: (context) => IngredientBloc()),
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
          builder: (context) => MainScreen(),
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
          builder: (context) => MainScreen(),
        );
    }
  }
}
