import 'package:flutter/material.dart';
import 'package:movie_helper/core/bottom-bar.dart';
import 'package:movie_helper/core/tabs/discover/discover.view.dart';
import 'package:movie_helper/core/tabs/search/search.view.dart';
import 'package:movie_helper/core/tabs/favorite/favorite.view.dart';
import 'package:movie_helper/services/authentification.service.dart';

class HomeScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  HomeScreen({this.auth, this.logoutCallback, this.userId});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> views;
  @override
  void initState() {
    views = <Widget>[
      DiscoverView(),
      FavoriteView(
        auth: widget.auth,
        userId: widget.userId,
        logoutCallback: widget.logoutCallback,
      ),
      SearchView(),
    ];
    super.initState();
  }

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
