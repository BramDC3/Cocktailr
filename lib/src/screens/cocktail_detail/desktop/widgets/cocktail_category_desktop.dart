import 'package:flutter/material.dart';

class CocktailCategoryDesktop extends StatelessWidget {
  final String category;

  CocktailCategoryDesktop({@required this.category});

  @override
  Widget build(BuildContext context) {
    return Text(
      category,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 18,
      ),
    );
  }
}