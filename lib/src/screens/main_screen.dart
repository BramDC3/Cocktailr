import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/screens/cocktail_list/cocktail_list_screen.dart';
import 'package:cocktailr/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainNavigationBloc _mainNavigationBloc;

  List<Widget> _screens = [
    HomeScreen(),
    CocktailListScreen(),
  ];

  List<String> _titles = [
    "Explore",
    "Cocktails",
  ];

  @override
  void initState() {
    super.initState();
    _mainNavigationBloc = MainNavigationBloc();
  }

  @override
  void dispose() {
    _mainNavigationBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: 0,
      stream: _mainNavigationBloc.currentIndex,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_titles[snapshot.data]),
            centerTitle: true,
          ),
          body: _screens[snapshot.data],
          bottomNavigationBar: _buildBottomNavigationBar(snapshot.data),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(int index) => BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.compass),
            title: Text("Explore"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_bar),
            title: Text("Cocktails"),
          ),
        ],
        onTap: _mainNavigationBloc.changeCurrentIndex,
        type: BottomNavigationBarType.fixed,
      );
}
