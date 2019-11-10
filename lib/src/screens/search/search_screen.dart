import 'package:cocktailr/src/screens/search/desktop/search_screen_desktop.dart';
import 'package:cocktailr/src/screens/search/mobile/search_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SearchScreenMobile(),
      desktop: SearchScreenDesktop(),
    );
  }
}
