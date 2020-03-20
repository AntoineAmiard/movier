import 'package:flutter/widgets.dart';
import 'package:movie_helper/models/overview.models.dart';
import 'package:movie_helper/models/season.models.dart';

class TV extends Overview {
  final String overview;
  final dynamic voteAverage;
  final DateTime releaseDate;
  final List<int> genresID;
  final List<SeasonOverview> seasonsOverview;

  TV({
    @required this.seasonsOverview,
    @required id,
    @required name,
    @required this.overview,
    @required this.voteAverage,
    @required this.releaseDate,
    @required posterPath,
    @required this.genresID,
  });

  factory TV.fromJson(Map<String, dynamic> json) {
    return TV(
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      voteAverage: json['vote_average'],
      releaseDate: DateTime.parse(['first_air_date'] as String),
      posterPath: json['poster_path'] as String,
      genresID: json['genres_ids'] as List<int>,
      seasonsOverview: json['seasons']
          .map((dynamic item) => SeasonOverview.fromJson(item))
          .toList(),
    );
  }
}
