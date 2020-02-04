import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'blocs/cocktail_bloc.dart';
import 'blocs/ingredient_bloc.dart';
import 'constants/app_config.dart';
import 'models/cocktail.dart';
import 'models/ingredient.dart';
import 'services/app_localizations.dart';
import 'services/service_locator.dart';
import 'services/navigation_router.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void dispose() {
    Hive.box<Cocktail>(cocktailBoxName).compact();
    Hive.box<Ingredient>(ingredientBoxName).compact();
    Hive.close();
    super.dispose();
  }

  Locale _localeResolutionCallback(Locale locale, Iterable<Locale> supportedLocales) {
    for (final supportedLocale in supportedLocales) {
      if (locale.languageCode == supportedLocale.languageCode) {
        return supportedLocale;
      }
    }

    return locale;
  }

  String _onGenerateTitle(BuildContext context) {
    return AppLocalizations.of(context).appTitle;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        Provider(builder: (_) => sl<CocktailBloc>()),
        Provider(builder: (_) => sl<IngredientBloc>()),
        Provider(builder: (_) => MainNavigationBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: roboto,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: sl<NavigationService>().navigatorKey,
        onGenerateRoute: sl<NavigationRouter>().router.generator,
        initialRoute: NavigationRouter.main,
        supportedLocales: const [
          Locale(english, belgium),
          Locale(dutch, belgium),
          Locale(french, belgium),
        ],
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: _localeResolutionCallback,
        onGenerateTitle: _onGenerateTitle,
      ),
    );
  }
}
