import 'package:cocktailr/src/fluro_router.dart';
import 'package:cocktailr/src/root.dart';
import 'package:flutter/material.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(Root());
}
