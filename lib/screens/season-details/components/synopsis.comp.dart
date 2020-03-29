import 'package:flutter/material.dart';

class SeasonSynopsis extends StatelessWidget {
  final String overview;

  SeasonSynopsis({this.overview});
  @override
  Widget build(BuildContext context) {
    print("overview : $overview");
    return Opacity(
      opacity: 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Synopsis",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            overview == "" ? "Aucun synopsis disponible" : overview,
            style: TextStyle(color: overview == "" ? Colors.red : null),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
