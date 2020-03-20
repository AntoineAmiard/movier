import 'package:flutter/material.dart';
import 'package:movie_helper/services/http.service.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

typedef void IndexCallback(int index);

class BottomBar extends StatefulWidget {
  final IndexCallback callback;
  @override
  _BottomBarState createState() => _BottomBarState();

  BottomBar({this.callback});
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              OMIcons.home,
              size: 25,
            ),
            title: Text("Accueil"),
            activeIcon: Icon(Icons.home)),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Favoris"),
            activeIcon: Icon(Icons.favorite)),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("Recherche"),
        )
      ],
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      unselectedIconTheme: IconThemeData(opacity: 0.5, size: 24),
      selectedIconTheme: IconThemeData(opacity: 1, size: 24),
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.callback(index);
  }
}
