import 'package:flutter/widgets.dart';
import 'package:movie_helper/models/episode.models.dart';
import 'package:movie_helper/models/video.models.dart';
import 'package:movie_helper/services/http.service.dart';
import 'package:movie_helper/services/json-parser.service.dart';

class SeasonOverview {
  final int id;
  final String name;
  final int seasonNumber;
  final int episodeCount;
  final String posterPath;

  SeasonOverview({
    @required this.posterPath,
    @required this.id,
    @required this.name,
    @required this.seasonNumber,
    @required this.episodeCount,
  });

  factory SeasonOverview.fromJson(Map<String, dynamic> json) {
    return SeasonOverview(
      id: json['id'] as int,
      name: json['name'] as String,
      seasonNumber: json['season_number'],
      episodeCount: json['episode_count'],
      posterPath: json['poster_path'],
    );
  }
}

class Season {
  final int id;
  final String name;
  final int seasonNumber;
  final int numberOfEpisode;
  final String posterPath;
  final DateTime airDate;
  final Video video;
  final String overview;
  final List<Episode> episodes;

  Season({
    @required this.airDate,
    @required this.numberOfEpisode,
    @required this.id,
    @required this.name,
    @required this.overview,
    @required this.seasonNumber,
    @required this.posterPath,
    @required this.episodes,
    @required this.video,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      airDate: DateTime.parse(json['air_date'] as String),
      numberOfEpisode: (json['episodes'] as List<dynamic>).length,
      id: json['id'] as int,
      name: json['name'] as String,
      video: parseVideos(
        json["videos"]["results"],
      ),
      overview: json['overview'] as String,
      seasonNumber: json['season_number'],
      posterPath: json['poster_path'],
      episodes: json['episodes']
          .map<Episode>((dynamic item) => Episode.fromJson(item))
          .toList(),
    );
  }
}
