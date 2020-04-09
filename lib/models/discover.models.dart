import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/tv.models.dart';

class Discover {
  final List<MovieOverview> popularMovies;
  final List<MovieOverview> topRatedMovies;
  final List<MovieOverview> nowPlayingMovies;
  final List<Genre> genresMovie;
  final List<TvOverview> popularTv;
  final List<TvOverview> topRatedTv;
  final List<Genre> genresTv;

  Discover({
    this.genresMovie,
    this.genresTv,
    this.nowPlayingMovies,
    this.popularMovies,
    this.popularTv,
    this.topRatedMovies,
    this.topRatedTv,
  });
}
