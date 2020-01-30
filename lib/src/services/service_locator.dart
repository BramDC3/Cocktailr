import 'package:cocktailr/src/constants/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import '../bases/database/cocktail_cache.dart';
import '../bases/database/ingredient_cache.dart';
import '../bases/network/api/cocktail_api.dart';
import '../bases/network/api/ingredient_api.dart';
import '../blocs/cocktail_bloc.dart';
import '../blocs/ingredient_bloc.dart';
import '../blocs/search_bloc.dart';
import '../database/cocktail_cache_impl.dart';
import '../database/ingredient_cache_impl.dart';
import '../models/cocktail.dart';
import '../models/ingredient.dart';
import '../network/api/cocktail_api_impl.dart';
import '../network/api/ingredient_api_impl.dart';
import '../network/interceptors/dio_interceptor.dart';
import '../network/loggers/dio_logger.dart';
import '../repositories/cocktail_repository.dart';
import '../repositories/ingredient_repository.dart';
import 'navigation_router.dart';
import 'navigation_service.dart';

final sl = GetIt.instance;

void init() async {
  // BLoCs
  sl.registerFactory(() => CocktailBloc(cocktailRepository: sl()));
  sl.registerFactory(() => IngredientBloc(ingredientRepository: sl()));
  sl.registerFactory(() => SearchBloc());

  // Repositories
  sl.registerLazySingleton(() => CocktailRepository(cocktailApi: sl(), cocktailCache: sl()));
  sl.registerLazySingleton(() => IngredientRepository(ingredientApi: sl(), ingredientCache: sl()));

  // APIs
  sl.registerLazySingleton<CocktailApi>(() => CocktailApiImpl(dio: sl()));
  sl.registerLazySingleton<IngredientApi>(() => IngredientApiImpl(dio: sl()));

  // Hive
  final cocktailBox = await Hive.openBox<Cocktail>('Cocktails');
  sl.registerLazySingleton<CocktailCache>(() => CocktailCacheImpl(cocktailBox: cocktailBox));
  final ingredientBox = await Hive.openBox<Ingredient>('Ingredients');
  sl.registerLazySingleton<IngredientCache>(() => IngredientCacheImpl(ingredientBox: ingredientBox));

  // Dio
  sl.registerLazySingleton(() => Dio(BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        baseUrl: baseUrl,
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

  // Navigation
  sl.registerLazySingleton(() => NavigationRouter());
  sl.registerLazySingleton(() => NavigationService());
}
