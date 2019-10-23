import 'package:flutter/material.dart';

class PopularIngredientLoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.height / 6,
          height: MediaQuery.of(context).size.height / 6,
        ),
      ),
    );
  }
}
