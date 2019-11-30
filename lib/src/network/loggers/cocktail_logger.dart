import 'package:cocktailr/src/bases/network/loggers/base_logger.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CocktailLogger extends BaseLogger {
  // TODO: Dependency Injection
  final logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      errorMethodCount: 4,
      printEmojis: false,
      printTime: true,
      lineLength: 120,
      methodCount: 0,
    ),
  );

  @override
  void printOnErrorLogs(DioError error) {
    final stringsToLog = List<String>();

    stringsToLog.add("==========Error Start==========");
    stringsToLog.add("${error.message} ${error.response?.request?.baseUrl}${error.response?.request?.path}");
    stringsToLog.add("${error.response?.data ?? 'Unknown Error'}");
    stringsToLog.add("==========Error End============");

    printErrorLog(stringsToLog);
  }

  @override
  void printOnRequestLogs(RequestOptions options) {
    final stringsToLog = List<String>();

    stringsToLog.add("==========Request Start==========");
    stringsToLog.add("${options.method?.toUpperCase() ?? 'METHOD'} ${options.baseUrl}${options.path}");

    if (options.headers != null && options.headers.isNotEmpty) {
      stringsToLog.add("Headers:");
      options.headers.forEach((k, v) => stringsToLog.add('$k: $v'));
    }

    if (options.queryParameters != null && options.queryParameters.isNotEmpty) {
      stringsToLog.add("Query Parameters:");
      options.queryParameters.forEach((k, v) => stringsToLog.add('$k: $v'));
    }

    if (options.data != null) {
      stringsToLog.add("Body: ${options.data}");
    }

    stringsToLog.add("==========Request End============");

    printRequestResponseLog(stringsToLog);
  }

  @override
  void printOnResponseLogs(Response response) {
    final stringsToLog = List<String>();

    stringsToLog.add("==========Response Start==========");
    stringsToLog.add("${response.statusCode} ${response.request?.baseUrl}${response.request?.path}");

    if (response.headers != null) {
      stringsToLog.add("Headers:");
      response.headers.forEach((k, v) => stringsToLog.add('$k: $v'));
    }

    stringsToLog.add("Response: ${response.data}");
    stringsToLog.add("==========Response End============");

    printRequestResponseLog(stringsToLog);
  }

  @override
  void printRequestResponseLog(List<String> stringsToLog) {
    logger.d(stringsToLog.join("\n"));
  }

  @override
  void printErrorLog(List<String> stringsToLog) {
    logger.e(stringsToLog.join("\n"));
  }
}
