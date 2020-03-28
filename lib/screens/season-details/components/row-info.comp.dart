import 'package:flutter/material.dart';

class SeasonRowInfo extends StatelessWidget {
  final int numberOfEpisode;
  final DateTime releaseDate;
  final double textIconSize = 17;
  final double textSize = 17;

  SeasonRowInfo({
    this.releaseDate,
    this.numberOfEpisode,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        height: 22,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildItem(
                icon: Icons.calendar_today, text: "${this.releaseDate.year}"),
            VerticalDivider(
              color: Colors.white,
            ),
            buildItem(
                icon: Icons.video_library,
                text: " ${this.numberOfEpisode} épisodes"),
          ],
        ),
      ),
    );
  }

  Widget buildItem({IconData icon, Color iconColor, String text}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: textSize),
        children: [
          WidgetSpan(
            child: Icon(
              icon,
              size: textIconSize + 2,
              color: iconColor,
            ),
          ),
          TextSpan(text: " " + text),
        ],
      ),
    );
  }
}
