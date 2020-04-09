import 'package:flutter/material.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/screens/search-list/components/appbar.comp.dart';
import 'package:movie_helper/screens/search-list/components/list-by-research.screen.dart';
import 'package:movie_helper/services/http.service.dart';

class MovieSearchList extends StatefulWidget {
  final String string;

  MovieSearchList({this.string});

  @override
  MovieSearchListState createState() => MovieSearchListState();
}

class MovieSearchListState extends State<MovieSearchList> {
  HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: "Resultats pour \"${widget.string}\"",
      ),
      // body: movies == null
      //     ? Center(child: CircularProgressIndicator())
      //     : ListByGenre.fromMovie(movies: movies),
      body: FutureBuilder(
        future: httpService.movieSearch(widget.string),
        builder:
            (BuildContext context, AsyncSnapshot<List<MovieOverview>> snap) {
          if (snap.hasData) {
            return ListByResearch.fromMovie(movies: snap.data);
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
