import 'package:flutter/material.dart';

class Info {
  final IconData icon;
  final String info;
  final Color color;

  Info({this.color, this.icon, this.info});
}

class RowInfo extends StatelessWidget {
  final List<Info> infos;

  final double textIconSize = 17;
  final double textSize = 17;

  RowInfo({this.infos});

  factory RowInfo.fromTv(
      {double voteAverage, DateTime releaseDate, int numberOfSeasons}) {
    return RowInfo(
      infos: [
        Info(
            info: "${releaseDate.year}",
            color: null,
            icon: Icons.calendar_today),
        Info(
            info: "$voteAverage / 10", color: Colors.yellow, icon: Icons.stars),
        Info(
            info: " $numberOfSeasons saisons",
            color: null,
            icon: Icons.video_library),
      ],
    );
  }

  factory RowInfo.fromSeason({DateTime releaseDate, int numberOfEpisode}) {
    return RowInfo(
      infos: [
        Info(
            info: "${releaseDate.year}",
            color: null,
            icon: Icons.calendar_today),
        Info(
            info: " $numberOfEpisode épisodes",
            color: null,
            icon: Icons.video_library),
      ],
    );
  }

  factory RowInfo.fromMovie(
      {double voteAverage, Duration runTime, DateTime releaseDate}) {
    return RowInfo(
      infos: [
        Info(
            info: "${releaseDate.year}",
            color: null,
            icon: Icons.calendar_today),
        Info(
            info: "$voteAverage / 10", color: Colors.yellow, icon: Icons.stars),
        Info(
            info: " ${runTime.inHours}h ${runTime.inMinutes.remainder(60)}min",
            color: null,
            icon: Icons.timer),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        height: 22,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(infos.length * 2 - 1, (int index) {
              if (index % 2 == 0) {
                Info item = infos[(index / 2).round()];
                return buildItem(
                  icon: item.icon,
                  iconColor: item.color,
                  text: item.info,
                );
              } else {
                return VerticalDivider(
                  color: Colors.white,
                );
              }
            })),
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
