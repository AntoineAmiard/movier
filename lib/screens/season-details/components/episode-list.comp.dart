import 'package:flutter/material.dart';
import 'package:movie_helper/models/episode.models.dart';

class EpisodeList extends StatelessWidget {
  final List<Episode> episodes;

  EpisodeList({this.episodes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Saisons",
          style: TextStyle(fontSize: 20),
        ),
        ListView.builder(
            padding: EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: episodes.length,
            itemBuilder: (BuildContext context, int index) {
              Episode episode = episodes[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      IntrinsicHeight(
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              "https://image.tmdb.org/t/p/w780/${episode.stillPath}",
                              height: 75,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    episode.name,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(fontSize: 10),
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.star,
                                            size: (10 + 2).toDouble(),
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                                " ${episode.voteAverage.toStringAsFixed(1)} / 10"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(episode.overview),
                      )
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
