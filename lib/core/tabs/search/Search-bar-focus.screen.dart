import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/search/components/result-list.comp.dart';
import 'package:movie_helper/core/tabs/search/components/search-bar.comp.dart';
import 'package:movie_helper/models/search.models.dart';
import 'package:movie_helper/services/http.service.dart';

class SearchBarFocus extends StatefulWidget {
  String searchString;

  SearchBarFocus({this.searchString});

  @override
  SearchBarFocusState createState() => SearchBarFocusState();
}

class SearchBarFocusState extends State<SearchBarFocus> {
  final HttpService httpService = HttpService();
  SearchResult result;

  @override
  void initState() {
    if (widget.searchString != null) {
      httpService
          .multiSearch(widget.searchString)
          .then((data) => setState(() => result = data));
    }
    super.initState();
  }

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
                    defaultSearch: widget.searchString != null
                        ? widget.searchString
                        : null,
                    onCompleteCallback: (String string) {
                      httpService
                          .multiSearch(string)
                          .then((data) => setState(() => result = data));
                      setState(() {
                        widget.searchString = string;
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
                          ResultList.fromMovie(
                              result.movies, widget.searchString),
                          SizedBox(
                            height: 50,
                          ),
                          ResultList.fromTv(result.tvs, widget.searchString),
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
