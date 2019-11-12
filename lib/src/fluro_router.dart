import 'package:cocktailr/src/screens/cocktail_list/cocktail_list_screen.dart';
import 'package:device_simulator/device_simulator.dart';
import 'package:fluro/fluro.dart';

import 'screens/cocktail_detail/mobile/cocktail_detail_screen_mobile.dart';
import 'screens/main/main_screen.dart';
import 'screens/search/search_screen.dart';

const bool debugEnableDeviceSimulator = true;

class FluroRouter {
  static Router router = Router();

  static String main = "/";
  static String cocktail = "/cocktail";
  static String cocktails = "/cocktails";
  static String search = "/search";

  static String cocktailIdParameter = "cocktailId";

  static void setupRouter() {
    router.define(main, handler: _mainHandler);
    router.define(cocktail, handler: _cocktailHandler);
    router.define(cocktails, handler: _cocktailsHandler);
    router.define(search, handler: _searchHandler);
  }

  static Handler _mainHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) => DeviceSimulator(
      enable: debugEnableDeviceSimulator,
      child: MainScreen(),
    ),
  );

  static Handler _cocktailHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) {
      String cocktailId = _parseCocktailId(params);
      return DeviceSimulator(
        enable: debugEnableDeviceSimulator,
        child: CocktailDetailScreenMobile(cocktailId: cocktailId),
      );
    },
  );

  static Handler _cocktailsHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) => DeviceSimulator(
      enable: debugEnableDeviceSimulator,
      child: CocktailListScreen(),
    ),
  );

  static Handler _searchHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) => DeviceSimulator(
      enable: debugEnableDeviceSimulator,
      child: SearchScreen(),
    ),
  );

  static String getCocktailDetailRoute(String cocktailId) {
    return "$cocktail?$cocktailIdParameter=$cocktailId";
  }

  static String _parseCocktailId(Map<String, List<String>> params) {
    String score = params[cocktailIdParameter]?.first;
    return score == null || score.isEmpty ? "11002" : score;
  }
}
