import 'package:movie_helper/models/overview.models.dart';
import 'package:movie_helper/models/video.models.dart';

Video parseVideos(List<dynamic> videosList) {
  for (Map<String, dynamic> video in videosList) {
    if (video['site'] == "YouTube") {
      return Video(id: video['key']);
    }
  }
  return Video(id: null);
}

List<Overview> parseCredits(Map<String, dynamic> json) {
  List<dynamic> actors = json["cast"];
  List<dynamic> crew = json["crew"];
  List<Overview> credits = new List<Overview>();
  actors.forEach((dynamic item) => credits.add(Overview.fromPeopleJson(item)));
  crew.forEach((dynamic item) => credits.add(Overview.fromPeopleJson(item)));
  return credits;
}
