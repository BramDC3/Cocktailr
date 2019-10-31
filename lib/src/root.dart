import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'blocs/cocktail_bloc.dart';
import 'blocs/ingredient_bloc.dart';
import 'fluro_router.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void dispose() {
    Hive.box('Cocktails').compact();
    Hive.box('Ingredients').compact();
    Hive.close();
    super.dispose();
  }

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
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Roboto',
        ),
        initialRoute: 'main',
        onGenerateRoute: FluroRouter.router.generator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
