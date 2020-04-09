import 'package:flutter/material.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/tv.models.dart';
import 'package:movie_helper/screens/list-by-genre/components/appbar.comp.dart';
import 'package:movie_helper/screens/list-by-genre/components/list-by-genre.screen.dart';
import 'package:movie_helper/services/http.service.dart';

class TvListByGenre extends StatefulWidget {
  final Genre genre;

  TvListByGenre({this.genre});

  @override
  TvListByGenreState createState() => TvListByGenreState();
}

class TvListByGenreState extends State<TvListByGenre> {
  HttpService httpService = HttpService();
  List<TvOverview> tvs;

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
        future: httpService.getTvByGenre(widget.genre.id),
        builder: (BuildContext context, AsyncSnapshot<List<TvOverview>> snap) {
          if (snap.hasData) {
            return ListByGenre.fromTv(tvs: snap.data);
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
