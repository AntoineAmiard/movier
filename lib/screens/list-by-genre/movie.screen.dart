import 'package:flutter/material.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/screens/list-by-genre/components/appbar.comp.dart';
import 'package:movie_helper/screens/list-by-genre/components/list-by-genre.screen.dart';
import 'package:movie_helper/services/http.service.dart';

class MovieListByGenre extends StatefulWidget {
  final Genre genre;

  MovieListByGenre({this.genre});

  @override
  MovieListByGenreState createState() => MovieListByGenreState();
}

class MovieListByGenreState extends State<MovieListByGenre> {
  HttpService httpService = HttpService();
  List<MovieOverview> movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        genreName: widget.genre.name,
      ),
      // body: movies == null
      //     ? Center(child: CircularProgressIndicator())
      //     : ListByGenre.fromMovie(movies: movies),
      body: FutureBuilder(
        future: httpService.getMoviebyGenre(widget.genre.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<MovieOverview>> snap) {
          if (snap.hasData) {
            return ListByGenre.fromMovie(movies: snap.data);
          } else if (snap.hasError) {
            return Center(
              child: Text("Erreur de chargement"),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
