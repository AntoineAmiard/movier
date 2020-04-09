import 'package:flutter/widgets.dart';

class Credit {
  final int id;
  final String name;
  final String profilePath;
  final String jobCharacter;

  Credit({this.id, this.name, this.profilePath, this.jobCharacter});

  factory Credit.fromJson(dynamic json) {
    return Credit(
      id: json['id'],
      name: json['name'],
      profilePath: json["profile_path"],
      jobCharacter: json['job'] ?? json['character'],
    );
  }
}

class People {
  final int id;
  final String name;
  final String profilePath;
  final String gender;
  final String biography;
  final String placeOfbirth;
  final String birthday;

  People({
    @required this.biography,
    @required this.birthday,
    @required this.gender,
    @required this.placeOfbirth,
    @required this.id,
    @required this.name,
    @required this.profilePath,
  });

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePath: json['profile_path'] as String,
      biography: json['biography'] as String,
      birthday: json['birthday'] as String,
      gender: json['gender'] == 2 ? "Man" : "Woman",
      placeOfbirth: json['place_of_birth'] as String,
    );
  }
}
