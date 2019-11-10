import 'package:cocktailr/src/screens/cocktail_list/desktop/cocktail_list_screen_desktop.dart';
import 'package:cocktailr/src/screens/cocktail_list/mobile/cocktail_list_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CocktailListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CocktailListScreenMobile(),
      desktop: CocktailListScreenDesktop(),
    );
  }
}
