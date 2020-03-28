import 'dart:convert';

import 'package:movie_helper/models/TV.models.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/language.models.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/overview.models.dart';
import 'package:movie_helper/models/people.models.dart';
import 'package:movie_helper/models/season.models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:movie_helper/config/config.dart';

class HttpService {
  final String host = "api.themoviedb.org";
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${config["token"]}'
  };
  String language = "fr";
  String region = "FR";

  HttpService() {
    // SharedPreferences.getInstance().then((prefs) {
    //   language = prefs.getString('language');
    //   region = prefs.getString('region');
    // });
  }

  // ###########################################
  // ---------------- Movie --------------------
  // ###########################################

  Future<List<Overview>> getDiscoverMovies() async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
    };
    var uri = Uri.https(host, "/3/discover/movie", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<Overview> movies =
          results.map((dynamic item) => Overview.fromMovieJson(item)).toList();
      return movies;
    } else {
      throw "Error getting discover movie data";
    }
  }

  Future<List<Overview>> getPopularMovies() async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
    };
    var uri = Uri.https(host, "/3/movie/popular", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<Overview> movies =
          results.map((dynamic item) => Overview.fromMovieJson(item)).toList();
      return movies;
    } else {
      throw "Error getting discover movie data";
    }
  }

  Future<List<Overview>> getNowPlayingMovies() async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
    };
    var uri = Uri.https(host, "/3/movie/now_playing", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<Overview> movies =
          results.map((dynamic item) => Overview.fromMovieJson(item)).toList();
      return movies;
    } else {
      throw "Error getting discover movie data";
    }
  }

  Future<List<Overview>> getTopRatedMovies() async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
    };
    var uri = Uri.https(host, "/3/movie/top_rated", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<Overview> movies =
          results.map((dynamic item) => Overview.fromMovieJson(item)).toList();
      return movies;
    } else {
      throw "Error getting discover movie data";
    }
  }

  Future<Movie> getMovieDetails(int id) async {
    Map<String, String> queryParams = {
      "language": language,
      "append_to_response": "videos,credits,similar"
    };
    Uri uri = Uri.https(host, "/3/movie/$id", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(res.body);
      Movie movieDetails = Movie.fromJson(result);
      return movieDetails;
    } else {
      throw "Error getting movie details data";
    }
  }

  Future<List<Genre>> getGenreMovie() async {
    Map<String, String> queryParams = {
      "language": language,
    };
    Uri uri = Uri.https(host, "3/genre/movie/list", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['genres'];
      List<Genre> genres =
          results.map((dynamic item) => Genre.fromJson(item)).toList();
      return genres;
    } else {
      throw "Error getting people details data";
    }
  }

  // ###########################################
  // ------------------- TV --------------------
  // ###########################################

  Future<List<Overview>> getDiscoverTV() async {
    Map<String, String> queryParams = {"language": language, "region": region};
    Uri uri = Uri.https(host, "/3/discover/tv", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<Overview> tv =
          results.map((dynamic item) => Overview.fromTVJson(item)).toList();
      return tv;
    } else {
      throw "Error getting discover tv data";
    }
  }

  Future<List<Overview>> getPopularTV() async {
    Map<String, String> queryParams = {"language": language, "region": region};
    Uri uri = Uri.https(host, "/3/tv/popular", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<Overview> tv =
          results.map((dynamic item) => Overview.fromTVJson(item)).toList();
      return tv;
    } else {
      throw "Error getting discover tv data";
    }
  }

  Future<List<Overview>> getTopRatedTV() async {
    Map<String, String> queryParams = {"language": language, "region": region};
    Uri uri = Uri.https(host, "/3/tv/top_rated", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<Overview> tv =
          results.map((dynamic item) => Overview.fromTVJson(item)).toList();
      return tv;
    } else {
      throw "Error getting discover tv data";
    }
  }

  Future<TV> getTVDetails(int id) async {
    Map<String, String> queryParams = {
      "language": language,
      "append_to_response": "credits,videos,similar"
    };
    Uri uri = Uri.https(host, "/3/tv/$id", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(res.body);
      TV tvDetails = TV.fromJson(result);
      return tvDetails;
    } else {
      throw "Error getting tv details data";
    }
  }

  Future<List<Genre>> getGenreTV() async {
    Map<String, String> queryParams = {
      "language": language,
    };
    Uri uri = Uri.https(host, "3/genre/tv/list", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['genres'];
      List<Genre> genres =
          results.map((dynamic item) => Genre.fromJson(item)).toList();
      return genres;
    } else {
      throw "Error getting people details data";
    }
  }

  Future<Season> getSeasonDetails(int TvId, int seasonNumber) async {
    Map<String, String> queryParams = {
      "language": language,
      "append_to_response": "videos",
    };
    Uri uri = Uri.https(host, "/3/tv/$TvId/season/$seasonNumber", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(res.body);
      Season seasonDetails = Season.fromJson(result);
      return seasonDetails;
    } else {
      throw "Error getting season data";
    }
  }

  // ###########################################
  // --------------- Language ------------------
  // ###########################################

  Future<List<Language>> getLanguages() async {
    Uri uri = Uri.https(host, "/3/configuartion/languages");
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Language> languages =
          body.map((dynamic item) => Language.fromJson(item)).toList();
      return languages;
    } else {
      throw 'Error getting languages data';
    }
  }

  // ###########################################
  // --------------- People --------------------
  // ###########################################

  Future<People> getPeopleDetails(int id) async {
    Map<String, String> queryParams = {
      "language": language,
    };
    Uri uri = Uri.https(host, "3/person/$id", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(res.body);
      People peopleDetails = People.fromJson(result);
      return peopleDetails;
    } else {
      throw "Error getting people details data";
    }
  }

  // ###########################################
  // --------------- Search --------------------
  // ###########################################

  Future<Map<String, dynamic>> multiSearch(String title) async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
      "query": title
    };
    Uri uri = Uri.https(host, "/3/search/multi", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      Map<String, List<dynamic>> searchResult = {"movies": [], "tv": []};
      results.forEach((dynamic item) {
        print(item);
        if (item["media_type"] == "movie")
          searchResult['movies'].add(Overview.fromMovieJson(item));
        if (item["media_type"] == "tv")
          searchResult['tv'].add(Overview.fromTVJson(item));
      });
      return searchResult;
    } else {
      throw "Error getting multi search data";
    }
  }
}
