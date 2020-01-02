import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';
import 'src/models/cocktail.dart';
import 'src/models/ingredient.dart';
import 'src/services/service_locator.dart' as di;

void main() async {
  // Solves Hive issue (ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized);
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive (not necessary on the web)
  if (!kIsWeb) {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);
  }

  // Register Hive TypeAdapters
  Hive.registerAdapter(CocktailAdapter(), 0);
  Hive.registerAdapter(IngredientAdapter(), 1);

  // Initialize Dependency Injection
  await di.init();

  // Run app
  runApp(App());
}
