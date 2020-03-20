import 'package:flutter/widgets.dart';

class Genre {
  final String name;
  final int id;

  Genre({@required this.name, @required this.id});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      name: json['name'],
      id: json['id'],
    );
  }
}
