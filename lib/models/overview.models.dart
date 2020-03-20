import 'package:flutter/material.dart';

class Overview {
  final String mediaType;
  final int id;
  final String title;
  final String posterPath;

  Overview({
    this.mediaType,
    @required this.id,
    @required this.title,
    @required this.posterPath,
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
    );
  }
}
