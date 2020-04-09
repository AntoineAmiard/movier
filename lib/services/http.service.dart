import 'dart:convert';

import 'package:movie_helper/models/search.models.dart';
import 'package:movie_helper/models/tv.models.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/language.models.dart';
import 'package:movie_helper/models/movie.models.dart';
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

  Future<List<MovieOverview>> getDiscoverMovies() async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
    };
    var uri = Uri.https(host, "/3/discover/movie", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<MovieOverview> movies =
          results.map((dynamic item) => MovieOverview.fromJson(item)).toList();
      return movies;
    } else {
      throw "Error getting discover movie data";
    }
  }

  Future<List<MovieOverview>> getPopularMovies() async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
    };
    var uri = Uri.https(host, "/3/movie/popular", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<MovieOverview> movies =
          results.map((dynamic item) => MovieOverview.fromJson(item)).toList();
      return movies;
    } else {
      throw "Error getting discover movie data";
    }
  }

  Future<List<MovieOverview>> getNowPlayingMovies() async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
    };
    var uri = Uri.https(host, "/3/movie/now_playing", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<MovieOverview> movies =
          results.map((dynamic item) => MovieOverview.fromJson(item)).toList();
      return movies;
    } else {
      throw "Error getting discover movie data";
    }
  }

  Future<List<MovieOverview>> getTopRatedMovies() async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
    };
    var uri = Uri.https(host, "/3/movie/top_rated", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<MovieOverview> movies =
          results.map((dynamic item) => MovieOverview.fromJson(item)).toList();
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

  Future<List<MovieOverview>> getMoviebyGenre(int genreId) async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
      "with_genres": "$genreId",
    };

    Uri uri = Uri.https(host, "/3/discover/movie", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];

      List<MovieOverview> movies =
          results.map((dynamic item) => MovieOverview.fromJson(item)).toList();

      return movies;
    } else {
      throw "Error getting movies by id data";
    }
  }

  // ###########################################
  // ------------------- TV --------------------
  // ###########################################

  Future<List<TvOverview>> getDiscoverTV() async {
    Map<String, String> queryParams = {"language": language, "region": region};
    Uri uri = Uri.https(host, "/3/discover/tv", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<TvOverview> tv =
          results.map((dynamic item) => TvOverview.fromJson(item)).toList();
      return tv;
    } else {
      throw "Error getting discover tv data";
    }
  }

  Future<List<TvOverview>> getPopularTV() async {
    Map<String, String> queryParams = {"language": language, "region": region};
    Uri uri = Uri.https(host, "/3/tv/popular", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<TvOverview> tv =
          results.map((dynamic item) => TvOverview.fromJson(item)).toList();
      return tv;
    } else {
      throw "Error getting discover tv data";
    }
  }

  Future<List<TvOverview>> getTopRatedTV() async {
    Map<String, String> queryParams = {"language": language, "region": region};
    Uri uri = Uri.https(host, "/3/tv/top_rated", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<TvOverview> tv =
          results.map((dynamic item) => TvOverview.fromJson(item)).toList();
      return tv;
    } else {
      throw "Error getting discover tv data";
    }
  }

  Future<Tv> getTvDetails(int id) async {
    Map<String, String> queryParams = {
      "language": language,
      "append_to_response": "credits,videos,similar"
    };
    Uri uri = Uri.https(host, "/3/tv/$id", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(res.body);
      Tv tvDetails = Tv.fromJson(result);
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

  Future<List<TvOverview>> getTvByGenre(int genreId) async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
      "with_genres": "$genreId",
    };
    Uri uri = Uri.https(host, "/3/discover/tv", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<TvOverview> tv =
          results.map((dynamic item) => TvOverview.fromJson(item)).toList();
      return tv;
    } else {
      throw "Error getting discover tv data";
    }
  }

  Future<Season> getSeasonDetails(int id, int seasonNumber) async {
    Map<String, String> queryParams = {
      "language": language,
      "append_to_response": "videos",
    };
    Uri uri = Uri.https(host, "/3/tv/$id/season/$seasonNumber", queryParams);
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

  Future<List<TvOverview>> tvSearch(String string) async {
    if (string == null) {
      return null;
    }

    Map<String, String> queryParams = {
      "language": language,
      "region": region,
      "query": string.replaceAll(new RegExp(r" "), "+"),
    };
    Uri uri = Uri.https(host, "/3/search/tv", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<TvOverview> tvs =
          results.map((dynamic item) => TvOverview.fromJson(item)).toList();
      return tvs;
    } else {
      throw "Error getting multi search data";
    }
  }

  Future<List<MovieOverview>> movieSearch(String string) async {
    if (string == null) {
      return null;
    }

    Map<String, String> queryParams = {
      "language": language,
      "query": string.replaceAll(new RegExp(r" "), "+"),
    };
    Uri uri = Uri.https(host, "/3/search/movie", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<MovieOverview> movies =
          results.map((dynamic item) => MovieOverview.fromJson(item)).toList();
      return movies;
    } else {
      throw "Error getting multi search data";
    }
  }

  Future<SearchResult> multiSearch(String string) async {
    if (string == null) {
      return null;
    }

    Map<String, String> queryParams = {
      "language": language,
      "query": string.replaceAll(new RegExp(r" "), "+"),
    };
    Uri uri = Uri.https(host, "/3/search/multi", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<MovieOverview> movies = new List<MovieOverview>();
      List<TvOverview> tvs = new List<TvOverview>();
      results.forEach((dynamic item) {
        if (item["poster_path"] != null && item["vote_average"] != 0) {
          if (item["media_type"] == "movie")
            movies.add(MovieOverview.fromJson(item));
          else if (item["media_type"] == "tv")
            tvs.add(TvOverview.fromJson(item));
        }
      });

      return SearchResult(
        movies: movies,
        tvs: tvs,
      );
    } else {
      throw "Error getting multi search data";
    }
  }

  Future<List<String>> getSuggestions(String string) async {
    Map<String, String> queryParams = {
      "language": language,
      "region": region,
      "query": string,
    };
    Uri uri = Uri.https(host, "/3/search/multi", queryParams);
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = jsonDecode(res.body)['results'];
      List<String> suggestions = results.map((dynamic item) {
        String infoName;
        if (item["media_type"] == "movie")
          infoName = "title";
        else if (item["media_type"] == "tv")
          infoName = "name";
        else
          return 'null';
        return item[infoName] as String;
      }).toList();
      return suggestions;
    } else {
      throw "Error getting suggestions";
    }
  }
}
