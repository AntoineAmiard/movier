import 'package:flutter/material.dart';
import 'package:movie_helper/models/tv.models.dart';
import 'package:movie_helper/screens/details/components/appbar.comp.dart';
import 'package:movie_helper/screens/details/components/credits.comp.dart';
import 'package:movie_helper/screens/details/components/genres.comp.dart';
import 'package:movie_helper/screens/details/components/row-info.comp.dart';
import 'package:movie_helper/screens/details/components/seasons-overview.comp.dart';
import 'package:movie_helper/screens/details/components/similars.comp.dart';
import 'package:movie_helper/screens/details/components/synopsis.comp.dart';
import 'package:movie_helper/services/http.service.dart';

import 'package:url_launcher/url_launcher.dart';

class TvDetailsScreen extends StatelessWidget {
  final HttpService httpService = HttpService();

  final int id;

  TvDetailsScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getTvDetails(this.id),
        builder: (BuildContext context, AsyncSnapshot<Tv> snap) {
          if (snap.hasData) {
            return TvDetailsBody(snap.data);
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

class TvDetailsBody extends StatefulWidget {
  final Tv tv;

  TvDetailsBody(this.tv);

  @override
  _TvDetailsBodyState createState() => _TvDetailsBodyState();
}

class _TvDetailsBodyState extends State<TvDetailsBody> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  HttpService httpService = HttpService();
  Tv tvDetails;
  ScrollController _scrollController;
  double appBarHeight = 100;
  double topFAB = 220;
  double posterHeight = 180;

  @override
  void initState() {
    super.initState();
    tvDetails = widget.tv;
    _scrollController = new ScrollController();
    _scrollController.addListener(() => scrollListener());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      body: this.tvDetails == null
          ? Center(child: CircularProgressIndicator())
          : new Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    CustomAppBar(
                      posterPath: tvDetails.posterPath,
                      title: tvDetails.title,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: GenreWrap(genres: tvDetails.genres),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: RowInfo.fromTv(
                                numberOfSeasons: tvDetails.numbeOfSeasons,
                                releaseDate: tvDetails.releaseDate,
                                voteAverage: tvDetails.voteAverage,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Synopsis(
                                overview: tvDetails.overview,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: SeasonsList(
                                seasons: tvDetails.seasonsOverview,
                                tvId: tvDetails.id,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Credits(
                                credits: tvDetails.credits,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Similars.fromTv(
                                tvs: tvDetails.similars,
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
                        heroTag: 'tv_youtube',
                        onPressed: _onTapPlay,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.live_tv),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: FloatingActionButton(
                          heroTag: 'tv_fav',
                          onPressed: _onTapFav,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.favorite_border),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 20,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w780/${tvDetails.posterPath}",
                        height: posterHeight,
                      ),
                    ),
                  ),
                )
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
    String url = "https://www.youtube.com/watch?v=${tvDetails.video.id}";
    if (await canLaunch(url))
      await launch(url);
    else
      displaySnackBar(
          message: "Impossible d'ouvrir le lien", backgroundColor: Colors.red);
  }

  void _onTapFav() {
    displaySnackBar(
      backgroundColor: Colors.teal,
      message: "Film \"${tvDetails.title}\" ajouté avec succés",
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
