import 'package:flutter/material.dart';
import 'package:movie_helper/models/season.models.dart';
import 'package:movie_helper/screens/details/components/appbar.comp.dart';
import 'package:movie_helper/screens/details/components/episode-list.comp.dart';
import 'package:movie_helper/screens/details/components/row-info.comp.dart';
import 'package:movie_helper/screens/details/components/synopsis.comp.dart';
import 'package:movie_helper/services/http.service.dart';

import 'package:url_launcher/url_launcher.dart';

class SeasonDetailsScreen extends StatelessWidget {
  final HttpService httpService = HttpService();

  final int id;
  final int seasonNumber;

  SeasonDetailsScreen({this.id, this.seasonNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getSeasonDetails(this.id, this.seasonNumber),
        builder: (BuildContext context, AsyncSnapshot<Season> snap) {
          if (snap.hasData) {
            return SeasonDetailsBody(snap.data);
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

class SeasonDetailsBody extends StatefulWidget {
  final Season season;

  SeasonDetailsBody(this.season);

  @override
  _SeasonDetailsBodyState createState() => _SeasonDetailsBodyState();
}

class _SeasonDetailsBodyState extends State<SeasonDetailsBody> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  Season seasonDetails;
  ScrollController _scrollController;
  double appBarHeight = 100;
  double topFAB = 220;
  double posterHeight = 200;

  @override
  void initState() {
    super.initState();
    seasonDetails = widget.season;
    _scrollController = new ScrollController();
    _scrollController.addListener(() => scrollListener());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      body: this.seasonDetails == null
          ? Center(child: CircularProgressIndicator())
          : new Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    CustomAppBar(
                        posterPath: seasonDetails.posterPath,
                        title: seasonDetails.name),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: RowInfo.fromSeason(
                                numberOfEpisode: seasonDetails.numberOfEpisode,
                                releaseDate: seasonDetails.airDate,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Synopsis(
                                overview: seasonDetails.overview,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: EpisodeList(
                                episodes: seasonDetails.episodes,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: topFAB,
                  right: 25.0,
                  child: FloatingActionButton(
                    onPressed: _onTapPlay,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.live_tv),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 20,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w780/${seasonDetails.posterPath}",
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
    String url = "https://www.youtube.com/watch?v=${seasonDetails.video.id}";
    if (seasonDetails.video.id == null)
      displaySnackBar(
          message: "Aucune video disponible", backgroundColor: Colors.red);
    else if (await canLaunch(url))
      await launch(url);
    else
      displaySnackBar(
          message: "Impossible d'ouvrir le lien", backgroundColor: Colors.red);
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
        onPressed: () => _scaffoldstate.currentState
            .hideCurrentSnackBar(reason: SnackBarClosedReason.action),
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
