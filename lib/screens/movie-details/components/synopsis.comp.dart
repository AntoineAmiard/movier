import 'package:flutter/material.dart';

class Synopsis extends StatelessWidget {
  final String overview;

  Synopsis({this.overview});
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
