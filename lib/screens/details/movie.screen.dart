import 'package:flutter/material.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/screens/details/components/appbar.comp.dart';
import 'package:movie_helper/screens/details/components/credits.comp.dart';
import 'package:movie_helper/screens/details/components/genres.comp.dart';
import 'package:movie_helper/screens/details/components/row-info.comp.dart';
import 'package:movie_helper/screens/details/components/similars.comp.dart';
import 'package:movie_helper/screens/details/components/synopsis.comp.dart';
import 'package:movie_helper/services/http.service.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatelessWidget {
  final HttpService httpService = HttpService();
  final int id;

  MovieDetailsScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getMovieDetails(this.id),
        builder: (BuildContext context, AsyncSnapshot<Movie> snap) {
          if (snap.hasData) {
            return MovieDetailsBody(snap.data);
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

class MovieDetailsBody extends StatefulWidget {
  final Movie movie;

  MovieDetailsBody(this.movie);

  @override
  _MovieDetailsBodyState createState() => _MovieDetailsBodyState();
}

class _MovieDetailsBodyState extends State<MovieDetailsBody> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  bool fav = false;
  Movie movieDetails;
  ScrollController _scrollController;
  double appBarHeight = 100;
  double topFAB = 220;
  double posterHeight = 200;

  @override
  void initState() {
    super.initState();
    movieDetails = widget.movie;
    _scrollController = new ScrollController();
    _scrollController.addListener(() => scrollListener());
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldstate,
      body: this.movieDetails == null
          ? Center(child: CircularProgressIndicator())
          : new Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    CustomAppBar(
                      posterPath: movieDetails.posterPath,
                      title: movieDetails.title,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: GenreWrap(genres: movieDetails.genres),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: RowInfo.fromMovie(
                                runTime: movieDetails.time,
                                releaseDate: movieDetails.releaseDate,
                                voteAverage: movieDetails.voteAverage,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Synopsis(
                                overview: movieDetails.overview,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Credits(
                                credits: movieDetails.credits,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Similars.fromMovie(
                                movies: movieDetails.similars,
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
                  child: Row(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: 'movie_youtube',
                        onPressed: _onTapPlay,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.live_tv),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: FloatingActionButton(
                          heroTag: 'movie_fav',
                          onPressed: _onTapFav,
                          backgroundColor: Colors.white,
                          child: Icon(
                              fav ? Icons.favorite : Icons.favorite_border),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 20,
                  child: Container(
                    height: posterHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w780/${movieDetails.posterPath}",
                        height: posterHeight,
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   top: 90,
                //   left: MediaQuery.of(context).size.width / 3 +
                //       (1 / 5) * posterHeight,
                //   child: Container(
                //     height: (2 / 3) * posterHeight,
                //     width: MediaQuery.of(context).size.width / 2,
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       "Very long long long text",
                //       maxLines: 2,
                //       style: textStyle.title,
                //     ),
                //   ),
                // ),
              ],
            ),
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

  void _onTapPlay() async {
    String url = "https://www.youtube.com/watch?v=${movieDetails.video.id}";
    if (await canLaunch(url))
      await launch(url);
    else
      displaySnackBar(
          message: "Impossible d'ouvrir le lien", backgroundColor: Colors.red);
  }

  void _onTapFav() {
    setState(() {
      fav = !fav;
    });
    displaySnackBar(
      backgroundColor: Colors.teal,
      message: "Film \"${movieDetails.title}\" ajouté avec succés",
    );
  }

  void displaySnackBar({String message, Color backgroundColor}) {
    final SnackBar snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
        overflow: TextOverflow.ellipsis,
      ),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        textColor: Colors.white,
        label: "OK",
        onPressed: () => _scaffoldstate.currentState.hideCurrentSnackBar(),
      ),
    );
    _scaffoldstate.currentState.showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
