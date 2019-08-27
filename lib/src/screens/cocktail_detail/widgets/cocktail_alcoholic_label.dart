import 'package:flutter/material.dart';

class CocktailAlcoholicLabel extends StatelessWidget {
  CocktailAlcoholicLabel({@required this.isAlcoholic});
  final bool isAlcoholic;

  @override
  Widget build(BuildContext context) {
    return Text(
      isAlcoholic ? "Alcoholic" : "Non-alcoholic",
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 18,
      ),
    );
  }
}
