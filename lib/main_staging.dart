import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cocktailr/src/di_container.dart' as di;
import 'package:path_provider/path_provider.dart';

import 'src/app_config.dart';
import 'src/fluro_router.dart';
import 'src/models/cocktail.dart';
import 'src/models/ingredient.dart';
import 'src/root.dart';

void main() async {
  // Set app flavor
  AppConfig.flavor = Flavor.STAGING;

  // Solves Hive issue (ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized);
  WidgetsFlutterBinding.ensureInitialized();

  // Initiate Hive (not necessary on the web)
  if (!kIsWeb) {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);
  }

  // Register Hive TypeAdapters
  Hive.registerAdapter(CocktailAdapter(), 0);
  Hive.registerAdapter(IngredientAdapter(), 1);

  // Initiate Dependency Injection
  await di.init();

  // Setup Fluro router for navigation
  FluroRouter.setupRouter();

  // Run app
  runApp(Root());
}
