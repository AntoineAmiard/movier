import 'package:flutter/material.dart';

import 'package:movie_helper/screens/movie-details/components/appbar.comp.dart';
import 'package:movie_helper/screens/movie-details/components/genres.comp.dart';
import 'package:movie_helper/screens/movie-details/components/row-info.comp.dart';
import 'package:movie_helper/screens/movie-details/components/synopsis.comp.dart';
import 'package:movie_helper/screens/movie-details/models/movie-screen.models.dart';
import 'package:movie_helper/services/http.service.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;

  MovieDetailsScreen({this.id});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  HttpService httpService = HttpService();
  MovieScreenData screenData;
  ScrollController _scrollController;
  double appBarHeight = 100;
  double topFAB = 220;
  double posterHeight = 220;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() => scrollListener());
    loadData().then((data) => setState(() => this.screenData = data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.screenData == null
          ? Center(child: CircularProgressIndicator())
          : new Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    MovieAppBar(
                      posterPath: screenData.movieDetails.posterPath,
                      title: screenData.movieDetails.title,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: GenreMovieWrap(
                                  genres: screenData.movieDetails.genres),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: RowInfo(
                                posterPath: screenData.movieDetails.posterPath,
                                time: screenData.movieDetails.time,
                                releaseDate:
                                    screenData.movieDetails.releaseDate,
                                voteAverage:
                                    screenData.movieDetails.voteAverage,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Synopsis(
                                overview: screenData.movieDetails.overview,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: topFAB,
                  right: 25.0,
                  child: new FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: new Icon(Icons.favorite_border),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 20,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w780/${screenData.movieDetails.posterPath}",
                        height: posterHeight,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Future<MovieScreenData> loadData() async {
    return MovieScreenData(
      movieDetails: await httpService.getMovieDetails(widget.id),
      similarMovie: await httpService.getSimilarMovies(widget.id),
    );
  }

  void scrollListener() {
    setState(() {
      topFAB = 220;
      posterHeight = 220;
    });
    if (_scrollController.hasClients) {
      setState(() {
        topFAB -= _scrollController.offset;
        posterHeight -= _scrollController.offset + 37;
      });
      if (topFAB == 0) {
        setState(() {
          topFAB = 220;
          posterHeight = 220;
        });
      } else if (topFAB < 155) {
        setState(() {
          topFAB = 155;
          posterHeight = 120;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
