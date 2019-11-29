import 'dart:async';

import 'package:cocktailr/src/network/loggers/cocktail_logger.dart';
import 'package:dio/dio.dart';

class CocktailInterceptors implements Interceptor {
  // TODO: Dependency Injection
  final _cocktailLogger = new CocktailLogger();
  final _cache = new Map<Uri, Response>();

  @override
  Future<dynamic> onError(DioError error) async {
    // if (err.message.contains("ERROR_001")) {
    //   // this will push a new route and remove all the routes that were present
    //   navigatorKey.currentState.pushNamedAndRemoveUntil(
    //       "/login", (Route<dynamic> route) => false);
    // }

    // return err;

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
    // if (options.headers.containsKey("requiresToken")) {
    //   //remove the auxiliary header
    //   options.headers.remove("requiresToken");

    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   var header = prefs.get("Header");

    //   options.headers.addAll({"Header": "$header${DateTime.now()}"});

    //   return options;
    // }

    _cocktailLogger.printOnRequestLogs(options);

    return options;
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    // if (options.headers.value("verifyToken") != null) {
    //   //if the header is present, then compare it with the Shared Prefs key
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   var verifyToken = prefs.get("VerifyToken");

    //   // if the value is the same as the header, continue with the request
    //   if (options.headers.value("verifyToken") == verifyToken) {
    //     return options;
    //   }
    // }

    // return DioError(request: options.request, error: "User is no longer active");

    _cocktailLogger.printOnResponseLogs(response);

    _cache[response.request.uri] = response;

    return response;
  }
}
