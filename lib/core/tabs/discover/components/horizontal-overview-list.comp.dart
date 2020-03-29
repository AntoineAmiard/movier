import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/discover/components/overview-item.comp.dart';
import 'package:movie_helper/models/overview.models.dart';
import 'package:movie_helper/screens/TV-details/tv-details.screen.dart';
import 'package:movie_helper/screens/movie-details/movie-details.screen.dart';

class HorizontalOverviewList extends StatelessWidget {
  final List<Overview> list;

  HorizontalOverviewList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) {
        Overview item = list[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            child: OverviewItem(name: item.title, posterPath: item.posterPath),
            onTap: () => item.mediaType == "movie"
                ? onMovieTap(item.id, context)
                : onTvTap(item.id, context),
          ),
        );
      },
    );
  }

  void onTvTap(int id, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TVDetailsScreen(
          id: id,
        ),
      ),
    );
  }

  void onMovieTap(int id, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(
          id: id,
        ),
      ),
    );
  }
}
