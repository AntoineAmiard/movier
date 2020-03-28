import 'package:flutter/material.dart';

class TVRowInfo extends StatelessWidget {
  final int numberOfEpisode;
  final int numberOfSeasons;
  final DateTime releaseDate;
  final double voteAverage;
  final double textIconSize = 17;
  final double textSize = 17;

  TVRowInfo({
    this.releaseDate,
    this.numberOfEpisode,
    this.voteAverage,
    this.numberOfSeasons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Opacity(
          opacity: 0.7,
          child: Container(
            height: 22,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: textSize),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.calendar_today,
                          size: textIconSize,
                        ),
                      ),
                      TextSpan(text: "  ${releaseDate.year}"),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: textSize),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.star,
                          size: textIconSize + 2,
                          color: Colors.yellow,
                        ),
                      ),
                      TextSpan(text: " $voteAverage / 10"),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: textSize),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.video_library,
                          size: textIconSize,
                        ),
                      ),
                      TextSpan(text: " ${this.numberOfSeasons} saisons"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
