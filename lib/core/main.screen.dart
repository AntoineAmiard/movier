import 'package:flutter/material.dart';
import 'package:movie_helper/core/bottom-bar.dart';
import 'package:movie_helper/core/tabs/discover/discover.view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> views = <Widget>[
    DiscoverView(),
    Text("Favoris"),
    Text("Recherche"),
  ];
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomBar(callback: (index) => setState(() => _tabIndex = index)),
      body: IndexedStack(
        children: views,
        index: _tabIndex,
      ),
    );
  }
}
