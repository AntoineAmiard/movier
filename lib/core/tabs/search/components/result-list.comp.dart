import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/tv.models.dart';
import 'package:movie_helper/screens/search-list/movie.screen.dart';
import 'package:movie_helper/screens/search-list/tv.screen.dart';

class Result {
  final String title;
  final String poster;
  final dynamic voteAverage;

  Result({
    this.title,
    this.poster,
    this.voteAverage,
  });
}

class ResultList extends StatelessWidget {
  final String searchString;
  final String title;
  final List<Result> results;
  final String mediaType;

  ResultList({this.title, this.results, this.mediaType, this.searchString});

  factory ResultList.fromMovie(
      List<MovieOverview> movies, String searchString) {
    return ResultList(
      results: movies
          .map(
            (MovieOverview movie) => Result(
              title: movie.title,
              poster: movie.posterPath,
              voteAverage: movie.voteAverage,
            ),
          )
          .toList(),
      title: "Films",
      mediaType: "movie",
      searchString: searchString,
    );
  }

  factory ResultList.fromTv(List<TvOverview> tvs, String searchString) {
    return ResultList(
      results: tvs
          .map((TvOverview tv) => Result(
                title: tv.title,
                poster: tv.posterPath,
                voteAverage: tv.voteAverage,
              ))
          .toList(),
      title: "Séries",
      mediaType: "tv",
      searchString: searchString,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: textStyle.display1,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemExtent: 75,
          physics: new ScrollPhysics(),
          itemCount: min(2, results.length),
          itemBuilder: (BuildContext context, int index) {
            Result item = results[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => {},
                child: ResultItem(
                  poster: item.poster,
                  title: item.title,
                  voteAverage: item.voteAverage,
                ),
              ),
            );
          },
        ),
        SizedBox(
          width: double.infinity,
          child: OutlineButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Voir plus "), Icon(Icons.chevron_right)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            onPressed: () => _onItemTap(context, searchString),
          ),
        ),
      ],
    );
  }

  void _onItemTap(context, String string) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (mediaType == "movie")
            return MovieSearchList(
              string: string,
            );
          else if (mediaType == "tv") return TvListSearch(string: string);
        },
        maintainState: true,
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  final String poster;
  final String title;
  final dynamic voteAverage;

  ResultItem({
    this.poster,
    this.title,
    this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(2.5),
          child: Image.network(
            "https://image.tmdb.org/t/p/w780/$poster",
            fit: BoxFit.fill,
            width: 50,
          ),
        ),
        SizedBox.fromSize(
          size: Size.fromWidth(10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  title,
                  style: textStyle.subhead,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: textStyle.body1,
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.stars,
                          size: textStyle.body1.fontSize + 2,
                          color: Colors.yellow,
                        ),
                      ),
                      TextSpan(text: " $voteAverage / 10"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
    );
  }
}
