import 'package:cocktailr/src/network/interceptors/cocktail_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CocktailClient {
  final Dio dio;
  final CocktailInterceptors cocktailInterceptors;

  get client => dio;

  CocktailClient({
    @required this.dio,
    @required this.cocktailInterceptors,
  }) {
    _initClient();
  }

  void _initClient() {
    dio..interceptors.add(cocktailInterceptors);
  }
}
