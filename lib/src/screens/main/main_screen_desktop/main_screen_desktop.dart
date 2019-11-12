import 'package:cocktailr/src/screens/home/home_screen.dart';
import 'package:cocktailr/src/widgets/desktop/menu_bar_desktop.dart';
import 'package:flutter/material.dart';

class MainScreenDesktop extends StatefulWidget {
  @override
  _MainScreenDesktopState createState() => _MainScreenDesktopState();
}

class _MainScreenDesktopState extends State<MainScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MenuBarDesktop(),
          Expanded(
            child: HomeScreen(),
          )
        ],
      ),
    );
  }
}
