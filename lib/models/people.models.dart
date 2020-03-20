import 'package:flutter/widgets.dart';
import 'package:movie_helper/models/overview.models.dart';

class People extends Overview {
  final String gender;
  final String biography;
  final String placeOfbirth;
  final String birthday;

  People({
    @required id,
    @required name,
    @required profilePath,
    @required this.biography,
    @required this.birthday,
    @required this.gender,
    @required this.placeOfbirth,
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
