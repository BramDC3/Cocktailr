import 'dart:async';

import 'package:cocktailr/src/network/loggers/dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioInterceptor implements Interceptor {
  final DioLogger dioLogger;
  final _cache = Map<Uri, Response>();

  DioInterceptor({@required this.dioLogger});

  @override
  Future<dynamic> onError(DioError error) async {
    dioLogger.printOnErrorLogs(error);

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
    dioLogger.printOnRequestLogs(options);

    return options;
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    dioLogger.printOnResponseLogs(response);

    _cache[response.request.uri] = response;

    return response;
  }
}
