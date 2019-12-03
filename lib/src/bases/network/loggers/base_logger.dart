import 'package:dio/dio.dart';

abstract class BaseLogger {
  void printOnRequestLogs(RequestOptions options);
  void printOnResponseLogs(Response response);
  void printOnErrorLogs(DioError error);
  void printRequestResponseLog(List<String> stringsToLog);
  void printErrorLog(List<String> stringsToLog);
}
