import 'package:flutter/widgets.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/overview.models.dart';
import 'package:movie_helper/models/people.models.dart';
import 'package:movie_helper/models/season.models.dart';
import 'package:movie_helper/models/video.models.dart';
import 'package:movie_helper/services/json-parser.dart';

class TV extends Overview {
  final String overview;
  final dynamic voteAverage;
  final DateTime releaseDate;
  final String title;
  final List<Overview> similar;
  final List<Overview> credits;
  final Video video;
  final int id;
  final String posterPath;
  final int numbeOfSeasons;
  final int numberOfEpisodes;
  final List<Genre> genres;
  final List<SeasonOverview> seasonsOverview;

  TV({
    @required this.credits,
    @required this.similar,
    @required this.seasonsOverview,
    @required this.id,
    @required this.title,
    @required this.overview,
    @required this.voteAverage,
    @required this.releaseDate,
    @required this.posterPath,
    @required this.genres,
    @required this.numberOfEpisodes,
    @required this.numbeOfSeasons,
    @required this.video,
  });

  factory TV.fromJson(Map<String, dynamic> json) {
    return TV(
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
      similar: json["similar"]['results']
          .map<Overview>((dynamic item) => Overview.fromTVJson(item))
          .toList(),
      credits: parseCredits(json['credits']),
    );
  }
}
