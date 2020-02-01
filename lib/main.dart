import 'dart:async';

import 'package:cocktailr/src/constants/app_config.dart';
import 'package:cocktailr/src/services/crash_reporting_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry/sentry.dart';

import 'src/root.dart';
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
  Hive.registerAdapter(CocktailAdapter());
  Hive.registerAdapter(IngredientAdapter());

  // Initialize environment variables
  await _initializeEnvironmentVariables();

  // Initialize Dependency Injection
  await di.init();

  // Send a crash report to sentry.io if a Flutter-specific error occurs (e.g. layout failures)
  FlutterError.onError = (FlutterErrorDetails details, {bool forceReport = false}) {
    _reportCrash(details.exception, details.stack);
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  };

  // Run app and send a crash report to sentry.io if the app crashes
  runZoned(
    () => runApp(Root()),
    onError: (Object error, StackTrace stackTrace) {
      _reportCrash(error, stackTrace);
    },
  );
}

Future<void> _initializeEnvironmentVariables() async {
  await DotEnv().load(environmentVariablesFilePath);
  sentryClient = SentryClient(dsn: DotEnv().env[sentryKey]);
}

void _reportCrash(dynamic error, StackTrace stackTrace) {
  try {
    sentryClient.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
    debugPrint('An error was sent to sentry.io: $error');
  } catch (e) {
    debugPrint('An error occurred while sending a crash report to sentry.io: $e');
    debugPrint('The error that was supposed to be reported to sentry.io: $error');
  }
}
