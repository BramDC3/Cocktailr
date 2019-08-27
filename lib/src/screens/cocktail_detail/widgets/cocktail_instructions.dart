import 'package:flutter/material.dart';

class CocktailInstructions extends StatelessWidget {
  CocktailInstructions({@required this.instructions, @required this.padding});
  final String instructions;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "How to make it:",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8),
          Text(
            instructions,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
