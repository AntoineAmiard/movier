import 'package:flutter/widgets.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/people.models.dart';
import 'package:movie_helper/models/video.models.dart';
import 'package:movie_helper/services/json-parser.dart';

class MovieOverview {
  final int id;
  final String overview;
  final dynamic voteAverage;
  final String title;
  final String posterPath;

  MovieOverview({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.voteAverage,
  });

  factory MovieOverview.fromJson(Map<String, dynamic> json) {
    return MovieOverview(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      voteAverage: json['vote_average'],
      posterPath: json['poster_path'] as String,
    );
  }
}

class Movie extends MovieOverview {
  final DateTime releaseDate;
  final List<MovieOverview> similars;
  final List<Credit> credits;
  final Video video;
  // final List<CompanyOverview> companies;
  final String tagline;
  final List<Genre> genres;
  final Duration time;
  final String backdropPath;

  Movie({
    id,
    title,
    posterPath,
    overview,
    voteAverage,
    @required this.video,
    @required this.credits,
    @required this.similars,
    @required this.releaseDate,
    @required this.genres,
    // @required this.companies,
    @required this.tagline,
    @required this.time,
    @required this.backdropPath,
  }) : super(
            id: id,
            title: title,
            posterPath: posterPath,
            overview: overview,
            voteAverage: voteAverage);

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
        video: parseVideos(
          json["videos"]["results"],
        ),
        similars: json["similar"]['results']
            .map<MovieOverview>((dynamic item) => MovieOverview.fromJson(item))
            .toList(),
        credits: parseCredits(json["credits"])
        // companies: (json['production_companies'] as List<dynamic>)
        //     .map<CompanyOverview>((dynamic item) => CompanyOverview.fromJson(item))
        //     .toList(),
        );
  }
}
