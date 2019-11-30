import 'dart:async';

import 'package:cocktailr/src/network/loggers/cocktail_logger.dart';
import 'package:dio/dio.dart';

class CocktailInterceptors implements Interceptor {
  // TODO: Dependency Injection
  final _cocktailLogger = CocktailLogger();
  final _cache = Map<Uri, Response>();

  @override
  Future<dynamic> onError(DioError error) async {
    _cocktailLogger.printOnErrorLogs(error);

    if (error.type != DioErrorType.CONNECT_TIMEOUT && error.type != DioErrorType.DEFAULT) {
      return error;
    }

    final cachedResponse = _cache[error.request.uri];
    if (cachedResponse != null) {
      return cachedResponse;
    }

    return error;
  }

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    _cocktailLogger.printOnRequestLogs(options);

    return options;
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    _cocktailLogger.printOnResponseLogs(response);

    _cache[response.request.uri] = response;

    return response;
  }
}
