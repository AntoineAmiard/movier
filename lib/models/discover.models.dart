import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/overview.models.dart';

class Discover {
  final List<Overview> popularMovies;
  final List<Overview> topRatedMovies;
  final List<Overview> nowPlayingMovies;
  final List<Genre> genresMovie;
  final List<Overview> popularTv;
  final List<Overview> topRatedTv;
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
