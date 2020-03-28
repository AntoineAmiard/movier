import 'package:flutter/material.dart';

class MovieRowInfo extends StatelessWidget {
  final String posterPath;
  final DateTime releaseDate;
  final Duration time;
  final double voteAverage;
  final double textIconSize = 17;
  final double textSize = 17;

  MovieRowInfo(
      {this.posterPath, this.releaseDate, this.time, this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Opacity(
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
                      Icons.access_time,
                      size: textIconSize,
                    ),
                  ),
                  TextSpan(
                      text:
                          " ${time.inHours}h ${time.inMinutes.remainder(60)}min"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
