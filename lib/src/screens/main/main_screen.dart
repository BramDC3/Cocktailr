import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'main_screen_desktop/main_screen_desktop.dart';
import 'main_screen_mobile/main_screen_mobile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MainScreenMobile(),
      desktop: MainScreenDesktop(),
    );
  }
}