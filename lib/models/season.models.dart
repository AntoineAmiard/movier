import 'package:flutter/widgets.dart';
import 'package:movie_helper/models/episode.models.dart';

class SeasonOverview {
  final int id;
  final String name;
  final int seasonNumber;
  final int episodeCount;

  SeasonOverview({
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
        episodeCount: json['episode_count']);
  }
}

class Season {
  final String airDate;
  final String overview;
  final String posterPath;
  final List<Episode> episodes;

  Season({
    @required this.airDate,
    @required episodeCount,
    @required id,
    @required name,
    @required this.overview,
    @required seasonNumber,
    @required this.posterPath,
    @required this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      airDate: json['air_date'] as String,
      episodeCount: json['episode_count'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      seasonNumber: json['season_number'],
      posterPath: json['poster_path'],
      episodes: json['episodes']
          .map((dynamic item) => Episode.fromJson(item))
          .toList(),
    );
  }
}
