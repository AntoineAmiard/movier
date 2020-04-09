import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/components/appbar.comp.dart';
import 'package:movie_helper/core/tabs/search/Search-bar-focus.screen.dart';
import 'package:movie_helper/core/tabs/search/components/fake-search-bar.comp.dart';
import 'package:movie_helper/core/tabs/search/components/last-search.comp.dart';
import 'package:movie_helper/services/http.service.dart';
import 'package:movie_helper/services/storage.service.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final Storage storage = Storage();
  final HttpService httpService = new HttpService();
  bool displaySearches = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: "Recherche",
          topLeftColor: Colors.teal,
          bottomRightColor: Colors.greenAccent,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Hero(
                tag: "search-bar",
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: GestureDetector(
                    onTap: () async => _onTap(context),
                    child: AbsorbPointer(
                      child: FakeSearchBar(),
                    ),
                  ),
                ),
              ),
              displaySearches
                  ? FutureBuilder(
                      future: storage.loadSearch(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<String>> snap) {
                        if (snap.hasData) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: LastSearches(
                              searches: snap.data,
                            ),
                          );
                        }
                        if (snap.hasError) {
                          return Text("Error");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  void _onTap(context) async {
    setState(() => displaySearches = false);

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SearchBarFocus();
      }),
    );
    print("refresh");
    setState(() => displaySearches = true);
    print("state");
  }
}
