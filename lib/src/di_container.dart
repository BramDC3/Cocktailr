import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/network/clients/cocktail_client.dart';
import 'package:cocktailr/src/network/cocktail_api_impl.dart';
import 'package:cocktailr/src/network/interceptors/cocktail_interceptors.dart';
import 'package:cocktailr/src/repositories/cocktail_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'app_config.dart';
import 'bases/network/cocktail_api.dart';
import 'network/loggers/cocktail_logger.dart';

final sl = GetIt.instance;

void init() {
  // BLoCs
  sl.registerFactory(() => CocktailBloc(cocktailRepository: sl()));

  // Repositories
  sl.registerLazySingleton(() => CocktailRepository(cocktailApi: sl()));

  // APIs
  sl.registerLazySingleton<CocktailApi>(() => CocktailApiImpl(cocktailClient: sl()));

  // Clients
  sl.registerLazySingleton(() => CocktailClient(
        dio: sl(),
        cocktailInterceptors: sl(),
      ));

  // Dio
  sl.registerLazySingleton(() => Dio(BaseOptions(
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        baseUrl: AppConfig.baseUrl,
      )));

  // Interceptors
  sl.registerLazySingleton(() => CocktailInterceptors(cocktailLogger: sl()));

  // Loggers
  sl.registerLazySingleton(() => Logger(
        printer: PrettyPrinter(
          colors: true,
          errorMethodCount: 4,
          printEmojis: false,
          printTime: true,
          lineLength: 120,
          methodCount: 0,
        ),
      ));
  sl.registerLazySingleton(() => CocktailLogger(logger: sl()));
}
