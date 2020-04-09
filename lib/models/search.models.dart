import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/tv.models.dart';

class SearchResult {
  final List<MovieOverview> movies;
  final List<TvOverview> tvs;

  SearchResult({this.movies, this.tvs});
}
