import 'package:flutter/widgets.dart';
import 'package:movie_helper/models/company.models.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/overview.models.dart';

class Movie extends Overview {
  final String overview;
  final dynamic voteAverage;
  final DateTime releaseDate;
  // final List<CompanyOverview> companies;
  final String tagline;
  final dynamic genres;
  final Duration time;
  final String backdropPath;
  final String title;
  final int id;
  final String posterPath;

  Movie({
    @required this.overview,
    @required this.voteAverage,
    @required this.releaseDate,
    @required this.genres,
    // @required this.companies,
    @required this.tagline,
    @required this.time,
    @required this.id,
    @required this.title,
    @required this.posterPath,
    @required this.backdropPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      backdropPath: json['backdrop_path'],
      title: json['title'] as String,
      overview: json['overview'] as String,
      voteAverage: json['vote_average'],
      releaseDate: DateTime.parse(json['release_date'] as String),
      posterPath: json['poster_path'] as String,
      genres: (json['genres'])
          .map<Genre>((dynamic item) => Genre.fromJson(item))
          .toList(),
      tagline: json['tagline'] as String,
      time: Duration(minutes: json['runtime'] as int),
      // companies: (json['production_companies'] as List<dynamic>)
      //     .map<CompanyOverview>((dynamic item) => CompanyOverview.fromJson(item))
      //     .toList(),
    );
  }
}
