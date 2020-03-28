import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/discover/components/overview-item.comp.dart';
import 'package:movie_helper/models/TV.models.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/overview.models.dart';
import 'package:movie_helper/services/http.service.dart';

class SimilarMovies extends StatelessWidget {
  final List<Overview> movies;

  SimilarMovies({this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Film similaire',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              Overview item = movies[index];
              return Padding(
                padding: EdgeInsets.only(right: 10),
                child:
                    OverviewItem(name: item.title, posterPath: item.posterPath),
              );
            },
          ),
        ),
      ],
    );
  }
}
