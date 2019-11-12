import 'package:cocktailr/src/fluro_router.dart';
import 'package:flutter/material.dart';

class MenuBarDesktop extends StatefulWidget {
  @override
  _MenuBarDesktopState createState() => _MenuBarDesktopState();
}

class _MenuBarDesktopState extends State<MenuBarDesktop> {
  Map<String, Widget> _icons;

  _MenuBarDesktopState() {
    _icons = Map.fromEntries([
      MapEntry<String, Widget>("Home", _menuIcon(Icons.home, "Home")),
      MapEntry<String, Widget>("Cocktails", _menuIcon(Icons.local_bar, "Cocktails")),
      MapEntry<String, Widget>("Search", _menuIcon(Icons.search, "Search")),
    ]);
  }

  void _navigateToScreen(String title) {
    switch (title) {
      case "Home":
        Navigator.of(context).pushNamed(FluroRouter.main);
        break;
      case "Cocktails":
        Navigator.of(context).pushNamed(FluroRouter.cocktails);
        break;
      case "Search":
        Navigator.of(context).pushNamed(FluroRouter.search);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ..._icons.values,
        ],
      ),
    );
  }

  Widget _menuIcon(IconData iconData, String title) => Container(
        padding: EdgeInsets.all(12),
        child: GestureDetector(
          onTap: () => _navigateToScreen(title),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                iconData,
                size: 50,
                color: Colors.white,
              ),
              Text(title, style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      );
}
