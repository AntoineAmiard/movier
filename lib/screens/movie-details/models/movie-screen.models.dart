import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/overview.models.dart';

class MovieScreenData {
  final Movie movieDetails;
  final List<Overview> similarMovie;

  MovieScreenData({
    this.movieDetails,
    this.similarMovie,
  });
}
