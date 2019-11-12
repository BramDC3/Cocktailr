import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'desktop/home_screen_desktop.dart';
import 'mobile/home_screen_mobile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeScreenMobile(),
      desktop: HomeScreenDesktop(),
    );
  }
}
