import 'dart:async';

import 'package:cocktailr/src/network/loggers/cocktail_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CocktailInterceptor implements Interceptor {
  final CocktailLogger cocktailLogger;
  final _cache = Map<Uri, Response>();

  CocktailInterceptor({@required this.cocktailLogger});

  @override
  Future<dynamic> onError(DioError error) async {
    cocktailLogger.printOnErrorLogs(error);

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
    cocktailLogger.printOnRequestLogs(options);

    return options;
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    cocktailLogger.printOnResponseLogs(response);

    _cache[response.request.uri] = response;

    return response;
  }
}
