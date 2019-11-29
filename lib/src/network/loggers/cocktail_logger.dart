import 'package:cocktailr/src/bases/network/loggers/base_logger.dart';
import 'package:dio/dio.dart';

class CocktailLogger extends BaseLogger {
  @override
  void printOnErrorLogs(DioError error) {
    print("<-- ${error.message} ${(error.response?.request != null ? (error.response.request.baseUrl + error.response.request.path) : 'URL')}");
    
    print("${error.response?.data ?? 'Unknown Error'}");

    print("<-- End error");
  }

  @override
  void printOnRequestLogs(RequestOptions options) {
    print("--> ${options.method?.toUpperCase() ?? 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");

    if (options.headers != null) {
      print("Headers:");
      options.headers.forEach((k, v) => print('$k: $v'));
    }

    if (options.queryParameters != null) {
      print("Query Parameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }

    if (options.data != null) {
      print("Body: ${options.data}");
    }

    print("--> END ${options.method?.toUpperCase() ?? 'METHOD'}");
  }

  @override
  void printOnResponseLogs(Response response) {
    print("<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");

    print("Headers:");
    response.headers?.forEach((k, v) => print('$k: $v'));

    print("Response: ${response.data}");

    print("<-- END HTTP");
  }
}
