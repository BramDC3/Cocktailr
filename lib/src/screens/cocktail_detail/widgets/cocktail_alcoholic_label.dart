import 'package:cocktailr/src/services/app_localizations.dart';
import 'package:flutter/material.dart';

class CocktailAlcoholicLabel extends StatelessWidget {
  final bool isAlcoholic;

  CocktailAlcoholicLabel({@required this.isAlcoholic});

  @override
  Widget build(BuildContext context) {
    return Text(
      isAlcoholic
          ? AppLocalizations.of(context).cocktailDetailLabelAlcoholic
          : AppLocalizations.of(context).cocktailDetailLabelNonAlcoholic,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 18,
      ),
    );
  }
}
