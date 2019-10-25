import 'package:cocktailr/src/fluro_router.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/models/ingredient.dart';
import 'package:cocktailr/src/root.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() {
  Hive.registerAdapter(CocktailAdapter(), 0);
  Hive.registerAdapter(IngredientAdapter(), 1);
  FluroRouter.setupRouter();
  runApp(Root());
}
