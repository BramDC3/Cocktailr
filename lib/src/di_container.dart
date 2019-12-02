import 'package:cocktailr/src/network/api/ingredient_api_impl.dart';
import 'package:cocktailr/src/network/interceptors/dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'app_config.dart';
import 'bases/network/api/cocktail_api.dart';
import 'bases/network/api/ingredient_api.dart';
import 'blocs/cocktail_bloc.dart';
import 'blocs/ingredient_bloc.dart';
import 'network/api/cocktail_api_impl.dart';
import 'network/loggers/dio_logger.dart';
import 'repositories/cocktail_repository.dart';
import 'repositories/ingredient_repository.dart';

final sl = GetIt.instance;

void init() {
  // BLoCs
  sl.registerFactory(() => CocktailBloc(cocktailRepository: sl()));
  sl.registerFactory(() => IngredientBloc(ingredientRepository: sl()));

  // Repositories
  sl.registerLazySingleton(() => CocktailRepository(cocktailApi: sl()));
  sl.registerLazySingleton(() => IngredientRepository(ingredientApi: sl()));

  // APIs
  sl.registerLazySingleton<CocktailApi>(() => CocktailApiImpl(dio: sl()));
  sl.registerLazySingleton<IngredientApi>(() => IngredientApiImpl(dio: sl()));

  // Dio
  sl.registerLazySingleton(() => Dio(BaseOptions(
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        baseUrl: AppConfig.baseUrl,
      ))..interceptors.add(DioInterceptor(dioLogger: sl())));

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
