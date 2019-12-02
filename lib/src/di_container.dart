import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'app_config.dart';
import 'bases/network/api/cocktail_api.dart';
import 'blocs/cocktail_bloc.dart';
import 'network/api/cocktail_api_impl.dart';
import 'network/clients/cocktail_client.dart';
import 'network/interceptors/cocktail_interceptor.dart';
import 'network/loggers/cocktail_logger.dart';
import 'repositories/cocktail_repository.dart';

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
        cocktailInterceptor: sl(),
      ));

  // Dio
  sl.registerLazySingleton(() => Dio(BaseOptions(
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        baseUrl: AppConfig.baseUrl,
      )));

  // Interceptors
  sl.registerLazySingleton(() => CocktailInterceptor(cocktailLogger: sl()));

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
