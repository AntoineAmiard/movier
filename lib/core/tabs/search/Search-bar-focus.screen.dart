import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/search/components/result-list.comp.dart';
import 'package:movie_helper/core/tabs/search/components/search-bar.comp.dart';
import 'package:movie_helper/models/search.models.dart';
import 'package:movie_helper/services/http.service.dart';

class SearchBarFocus extends StatefulWidget {
  @override
  SearchBarFocusState createState() => SearchBarFocusState();
}

class SearchBarFocusState extends State<SearchBarFocus> {
  final HttpService httpService = HttpService();
  SearchResult result;
  String searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SafeArea(
                child: Hero(
                  tag: 'search-bar',
                  child: SearchBar(
                    onCompleteCallback: (String string) {
                      httpService
                          .multiSearch(string)
                          .then((data) => setState(() => result = data));
                      setState(() {
                        searchString = string;
                      });
                    },
                  ),
                ),
              ),
            ),
            result == null
                ? SliverToBoxAdapter()
                : SliverPadding(
                    padding: EdgeInsets.only(top: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ResultList.fromMovie(result.movies, searchString),
                          SizedBox(
                            height: 50,
                          ),
                          ResultList.fromTv(result.tvs, searchString),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
