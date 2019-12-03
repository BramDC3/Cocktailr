import 'package:cocktailr/src/database/ingredient_cache_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'app_config.dart';
import 'bases/database/cocktail_cache.dart';
import 'bases/database/ingredient_cache.dart';
import 'bases/network/api/cocktail_api.dart';
import 'bases/network/api/ingredient_api.dart';
import 'blocs/cocktail_bloc.dart';
import 'blocs/ingredient_bloc.dart';
import 'database/cocktail_cache_impl.dart';
import 'network/api/cocktail_api_impl.dart';
import 'network/api/ingredient_api_impl.dart';
import 'network/interceptors/dio_interceptor.dart';
import 'network/loggers/dio_logger.dart';
import 'repositories/cocktail_repository.dart';
import 'repositories/ingredient_repository.dart';

final sl = GetIt.instance;

void init() {
  // BLoCs
  sl.registerFactory(() => CocktailBloc(cocktailRepository: sl()));
  sl.registerFactory(() => IngredientBloc(ingredientRepository: sl()));

  // Repositories
  sl.registerLazySingleton(() => CocktailRepository(cocktailApi: sl(), cocktailCache: sl()));
  sl.registerLazySingleton(() => IngredientRepository(ingredientApi: sl(), ingredientCache: sl()));

  // APIs
  sl.registerLazySingleton<CocktailApi>(() => CocktailApiImpl(dio: sl()));
  sl.registerLazySingleton<IngredientApi>(() => IngredientApiImpl(dio: sl()));

  // Caches
  sl.registerLazySingleton<CocktailCache>(() => CocktailCacheImpl());
  sl.registerLazySingleton<IngredientCache>(() => IngredientCacheImpl());

  // Dio
  sl.registerLazySingleton(() => Dio(BaseOptions(
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        baseUrl: AppConfig.baseUrl,
      ))..interceptors.add(sl()));

  // Interceptors
  sl.registerLazySingleton<Interceptor>(() => DioInterceptor(dioLogger: sl()));

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
  sl.registerLazySingleton(() => DioLogger(logger: sl()));
}
