import 'package:dio/dio.dart';

abstract class BaseLogger {
  void printOnRequestLogs(RequestOptions options);
  void printOnResponseLogs(Response response);
  void printOnErrorLogs(DioError error);
}
