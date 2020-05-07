import 'package:movie_helper/models/people.models.dart';
import 'package:movie_helper/models/video.models.dart';

Video parseVideos(List<dynamic> videosList) {
  for (Map<String, dynamic> video in videosList) {
    if (video['site'] == "YouTube") {
      return Video(id: video['key']);
    }
  }
  return Video(id: null);
}

List<Credit> parseCredits(Map<String, dynamic> json) {
  List<dynamic> actors = json["cast"];
  List<dynamic> crew = json["crew"];
  List<Credit> credits = new List<Credit>();
  actors.forEach((dynamic item) => credits.add(Credit.fromJson(item)));
  crew.forEach((dynamic item) => credits.add(Credit.fromJson(item)));
  return credits;
}
