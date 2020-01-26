import 'package:cocktailr/src/screens/cocktail_detail/cocktail_detail_screen.dart';
import 'package:cocktailr/src/screens/main_screen.dart';
import 'package:cocktailr/src/screens/search/search_screen.dart';
import 'package:fluro/fluro.dart';

import 'service_locator.dart';

class NavigationRouter {
  static const String main = "/";
  static const String cocktail = "/cocktail";
  static const String search = "/search";

  static const String cocktailIdParameter = "cocktailId";

  final router = Router();

  NavigationRouter() {
    _setupRouter();
  }

  void _setupRouter() {
    router.define(main, handler: _mainHandler, transitionType: TransitionType.native);
    router.define(cocktail, handler: _cocktailHandler, transitionType: TransitionType.native);
    router.define(search, handler: _searchHandler, transitionType: TransitionType.native);
  }

  final _mainHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) => MainScreen(),
  );

  final _cocktailHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) {
      final cocktailId = _parseCocktailId(params);
      return CocktailDetailScreen(cocktailId: cocktailId);
    },
  );

  final _searchHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) => SearchScreen(searchBloc: sl()),
  );

  static String getCocktailDetailRoute(String cocktailId) {
    return "$cocktail?$cocktailIdParameter=$cocktailId";
  }

  static String _parseCocktailId(Map<String, List<String>> params) {
    final score = params[cocktailIdParameter]?.first;
    return score == null || score.isEmpty ? "11002" : score;
  }
}
