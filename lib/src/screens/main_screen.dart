import 'package:cocktailr/src/blocs/main_navigation_bloc.dart';
import 'package:cocktailr/src/screens/cocktail_list/cocktail_list_screen.dart';
import 'package:cocktailr/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    CocktailListScreen(),
  ];

  final List<String> _titles = [
    "Explore",
    "Cocktails",
  ];

  Future<void> _onSearchIconPressed(BuildContext context) async {
    Navigator.pushNamed(context, '/search');
  }

  Future<bool> _onWillPop(MainNavigationBloc bloc, int index) {
    if (index == 0) return Future.value(true);
    bloc.changeCurrentIndex(0);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final mainNavigationBloc = Provider.of<MainNavigationBloc>(context);

    return StreamBuilder(
      initialData: 0,
      stream: mainNavigationBloc.currentIndex,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return WillPopScope(
          onWillPop: () => _onWillPop(
            mainNavigationBloc,
            snapshot.data,
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(_titles[snapshot.data]),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _onSearchIconPressed(context),
                  tooltip: "Search cocktails",
                )
              ],
            ),
            body: _screens[snapshot.data],
            bottomNavigationBar: _buildBottomNavigationBar(
              snapshot.data,
              mainNavigationBloc,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(int index, MainNavigationBloc bloc) =>
      BottomNavigationBar(
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
        onTap: bloc.changeCurrentIndex,
        type: BottomNavigationBarType.fixed,
      );
}
