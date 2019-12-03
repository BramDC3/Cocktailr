import 'package:cocktailr/src/fluro_router.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:cocktailr/src/root.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cocktailr/src/di_container.dart' as di;
import 'package:path_provider/path_provider.dart';

void main() async {
  // Solves Hive issue (ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized);
  WidgetsFlutterBinding.ensureInitialized();

  // Initiate Dependency Injection
  di.init();

  // Initiate Hive (not necessary on the web)
  if (!kIsWeb) {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);
  }

  // Register Hive TypeAdapters
  Hive.registerAdapter(CocktailAdapter(), 0);
  Hive.registerAdapter(IngredientAdapter(), 1);

  // Setup Fluro router for navigation
  FluroRouter.setupRouter();

  // Run app
  runApp(Root());
}
