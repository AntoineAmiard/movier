import 'package:flutter/material.dart';
import 'package:movie_helper/models/episode.models.dart';

class EpisodeList extends StatelessWidget {
  final List<Episode> episodes;

  EpisodeList({this.episodes});

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Saisons",
          style: textStyle.title,
        ),
        ListView.builder(
            padding: EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: episodes.length,
            itemBuilder: (BuildContext context, int index) {
              Episode episode = episodes[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      IntrinsicHeight(
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w780/${episode.stillPath}",
                                height: 80,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 90,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            episode.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.title,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                              style: textStyle.subtitle,
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.stars,
                                                    size: textStyle
                                                            .subtitle.fontSize
                                                            .toDouble() +
                                                        2,
                                                    color: Colors.yellow,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      " ${episode.voteAverage.toStringAsFixed(1)} / 10",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          episode.overview,
                          style: textStyle.body1,
                        ),
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
