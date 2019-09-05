import 'package:cocktailr/src/screens/search/search_screen.dart';
import 'package:fluro/fluro.dart';

import 'screens/cocktail_detail/cocktail_detail_screen.dart';
import 'screens/main_screen.dart';

class FluroRouter {
  static Router router = Router();

  static String main = "/";
  static String cocktail = "/cocktail";
  static String search = "/search";

  static String cocktailIdParameter = "cocktailId";

  static void setupRouter() {
    router.define(main, handler: _mainHandler);
    router.define(cocktail, handler: _cocktailHandler);
    router.define(search, handler: _searchHandler);
  }

  static Handler _mainHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) => MainScreen(),
  );

  static Handler _cocktailHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) {
      String cocktailId = _parseCocktailId(params);
      return CocktailDetailScreen(cocktailId: cocktailId);
    },
  );

  static Handler _searchHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) => SearchScreen(),
  );

  static String getCocktailDetailRoute(String cocktailId) {
    return "$cocktail?$cocktailIdParameter=$cocktailId";
  }

  static String _parseCocktailId(Map<String, List<String>> params) {
    String score = params[cocktailIdParameter]?.first;
    return score == null || score.isEmpty ? "11002" : score;
  }
}
