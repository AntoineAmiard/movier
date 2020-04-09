import 'package:flutter/widgets.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/people.models.dart';
import 'package:movie_helper/models/season.models.dart';
import 'package:movie_helper/models/video.models.dart';
import 'package:movie_helper/services/json-parser.dart';

class TvOverview {
  final int id;
  final String overview;
  final dynamic voteAverage;
  final String posterPath;
  final String title;

  TvOverview({
    this.id,
    this.overview,
    this.posterPath,
    this.title,
    this.voteAverage,
  });

  factory TvOverview.fromJson(Map<String, dynamic> json) {
    return TvOverview(
      id: json['id'] as int,
      title: json['name'] as String,
      posterPath: json['poster_path'] as String,
      overview: json['overview'] as String,
      voteAverage: json['vote_average'],
    );
  }
}

class Tv extends TvOverview {
  final DateTime releaseDate;
  final List<TvOverview> similars;
  final List<Credit> credits;
  final Video video;

  final int numbeOfSeasons;
  final int numberOfEpisodes;
  final List<Genre> genres;
  final List<SeasonOverview> seasonsOverview;

  Tv({
    id,
    title,
    overview,
    voteAverage,
    posterPath,
    @required this.credits,
    @required this.similars,
    @required this.seasonsOverview,
    @required this.releaseDate,
    @required this.genres,
    @required this.numberOfEpisodes,
    @required this.numbeOfSeasons,
    @required this.video,
  }) : super(
          id: id,
          title: title,
          overview: overview,
          voteAverage: voteAverage,
          posterPath: posterPath,
        );

  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
      id: json['id'] as int,
      title: json['name'] as String,
      overview: json['overview'] as String,
      voteAverage: json['vote_average'],
      releaseDate: DateTime.parse(json['first_air_date'] as String),
      posterPath: json['poster_path'] as String,
      genres: (json['genres'])
          .map<Genre>((dynamic item) => Genre.fromJson(item))
          .toList(),
      seasonsOverview: json['seasons']
          .map<SeasonOverview>((dynamic item) => SeasonOverview.fromJson(item))
          .toList(),
      numbeOfSeasons: json['number_of_seasons'] as int,
      numberOfEpisodes: json['number_of_episodes'] as int,
      video: parseVideos(
        json['videos']['results'],
      ),
      similars: json["similar"]['results']
          .map<TvOverview>((dynamic item) => TvOverview.fromJson(item))
          .toList(),
      credits: parseCredits(json['credits']),
    );
  }
}
