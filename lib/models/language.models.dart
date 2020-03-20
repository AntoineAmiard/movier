import 'package:flutter/widgets.dart';

class Language {
  final String name;
  final String iso_639_1;

  Language({@required this.name, @required this.iso_639_1});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'].isEmpty ? json['english_name'] : json['name'],
      iso_639_1: json['iso_639_1'],
    );
  }
}
