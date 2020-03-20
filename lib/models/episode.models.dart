import 'package:flutter/widgets.dart';

class Episode {
  final int id;
  final String name;
  final String overview;
  final String stillPath;

  Episode({
    @required this.id,
    @required this.name,
    @required this.overview,
    @required this.stillPath,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      stillPath: json['still_path'],
    );
  }
}
