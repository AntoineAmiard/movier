import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_helper/config/config.dart';

class Overview {
  final String mediaType;
  final int id;
  final String title;
  final String posterPath;
  final String jobCharacter;

  Overview({
    this.jobCharacter,
    this.mediaType,
    this.id,
    this.title,
    this.posterPath,
  });

  factory Overview.fromMovieJson(Map<String, dynamic> json) {
    return Overview(
      mediaType: "movie",
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String,
    );
  }

  factory Overview.fromTVJson(Map<String, dynamic> json) {
    return Overview(
      mediaType: "tv",
      id: json['id'] as int,
      title: json['name'] as String,
      posterPath: json['poster_path'] as String,
    );
  }

  factory Overview.fromPeopleJson(dynamic json) {
    return Overview(
      mediaType: "people",
      id: json['id'],
      title: json['name'],
      posterPath: json["profile_path"],
      jobCharacter: json['job'] ?? json['character'],
    );
  }
}

class SeasonOverview {
  final int id;
  final String name;
  final int seasonNumber;
  final int episodeCount;
  final String posterPath;

  SeasonOverview({
    this.posterPath,
    this.id,
    this.name,
    this.seasonNumber,
    this.episodeCount,
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

class TV extends Overview {
  final String overview;
  final dynamic voteAverage;
  final DateTime releaseDate;
  final int numbeOfSeasons;
  final int numberOfEpisodes;
  final String title;
  final int id;
  final String posterPath;
  // final List<Genre> genres;
  final List<SeasonOverview> seasonsOverview;

  TV({
    this.seasonsOverview,
    this.numbeOfSeasons,
    this.numberOfEpisodes,
    this.id,
    this.title,
    this.overview,
    this.voteAverage,
    this.releaseDate,
    this.posterPath,
    // this.genres,
  });

  factory TV.fromJson(Map<String, dynamic> json) {
    return TV(
      id: json['id'] as int,
      title: json['name'],
      overview: json['overview'] as String,
      voteAverage: json['vote_average'],
      releaseDate: DateTime.parse(json['first_air_date'] as String),
      posterPath: json['poster_path'] as String,
      numbeOfSeasons: json['number_of_seasons'] as int,
      numberOfEpisodes: json['number_of_episodes'] as int,
      //   genres: (json['genres'])
      //       .map<Genre>((dynamic item) => Genre.fromJson(item))
      //       .toList(),
      seasonsOverview: json['seasons']
          .map<SeasonOverview>((dynamic item) => SeasonOverview.fromJson(item))
          .toList(),
    );
  }
}

main() async {
  final String host = "api.themoviedb.org";
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${config["token"]}'
  };
  final int id = 42009;
  Map<String, String> queryParams = {
    "language": 'fr',
  };
  Uri uri = Uri.https(host, "/3/tv/$id", queryParams);
  var res = await http.get(uri, headers: headers);
  if (res.statusCode == 200) {
    Map<String, dynamic> result = jsonDecode(res.body);
    // print(result['name']);
    TV tvDetails = TV.fromJson(result);
    print(tvDetails.seasonsOverview[0].posterPath);
  } else {
    throw "Error getting tv details data";
  }
}
