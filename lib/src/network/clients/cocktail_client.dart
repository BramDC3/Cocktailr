import 'package:cocktailr/src/bases/network/clients/base_client.dart';
import 'package:cocktailr/src/network/interceptors/cocktail_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CocktailClient implements BaseClient {
  final Dio dio;
  final CocktailInterceptor cocktailInterceptor;

  get client => dio;

  CocktailClient({
    @required this.dio,
    @required this.cocktailInterceptor,
  }) {
    initClient();
  }

  @override
  void initClient() {
    dio..interceptors.add(cocktailInterceptor);
  }
}
