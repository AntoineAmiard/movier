import 'package:flutter/material.dart';

class TVSynopsis extends StatelessWidget {
  final String overview;

  TVSynopsis({this.overview});
  @override
  Widget build(BuildContext context) {
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
            overview,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
